# Simple ansible role to install and maintain the Bind9 nameserver

This role installs and configures the Bind9 nameserver on Debian and Ubuntu.

## Basic server configuration

### Primary server

Set vars for your primary server, for instance in `host_vars/primary_name/vars/XX_bind.yml`.

An example: using `example.test` static zones and forwarder:

```yaml
bind9_authoritative: true
bind9_admin_email: hostmaster@example2.test
bind9_forwarder: true
bind9_forwarders:
  - 1.1.1.1
  - 8.8.8.8
bind9_zones:
  - name: example.test
    serial: "1694903878"
    ttl: 1d
    refresh: 1h
    retry: 30m
    expire: 2d
    minimum: 15m
    ns_records:
      # The first NS record will be used in the SOA
      - ns1
      - ns2.example2.test.
    resource_records:
      - label: "@"
        type: MX
        content: mail1
        priority: 10
      - label: ns1
        ttl: 1h
        type: A
        content: 192.168.0.1
      - label: mail1
        ttl: 1h
        type: A
        content: 192.168.254.4
      - label: www
        ttl: 10m
        type: A
        content: 192.168.254.7
      - label: ftp1
        ttl: 2h
        type: CNAME
        content: www
      - label: ftp2
        ttl: 1h
        type: CNAME
        content: ftp.example2.test.
      - label: something
        type: CNAME
        content: www.example.test.
      # - label: subdomain
      #   ttl: 30m # see TTL section for examples
      #   type: A|CNAME|TXT|...
      #   content: IP|other-subdomain|fqdn|etc
```

#### Zone file example

The file `/etc/bind/named.conf.local` will contain:

```zone
zone "example.test" {
  type primary;
  file "/etc/bind/zones/db.example.test";
  notify yes;
};
```

The file `/etc/bind/zones/db.example.test` will contain:

```zone
;; Ansible managed

; zone file for example.test

$TTL 1d    ; default TTL for zone
$ORIGIN example.test.
; Start of Authority
@         IN      SOA   ns1 hostmaster.example2.test. (
                  ; Serial number
                  1694903878
                  ; Refresh
                  1h
                  ; Retry
                  30m
                  ; Expire
                  2d
                  ; Minimum
                  15m
)

                     IN        NS           ns1
                     IN        NS           ns2.example2.test2.
@                    IN        MX       10  mail1
ns1                  IN 1h     A            192.168.0.1
mail1                IN 1h     A            192.168.254.4
www                  IN 10m    A            192.168.254.7
ftp1                 IN 2h     CNAME        www
ftp2                 IN 1h     CNAME        ftp.example2.test.
something            IN        CNAME        www.example.test.
```

**Notes:**

- **This role will take care of using the proper format for the SOA email.**\
  The DNS administrator email in the zone file for the SOA uses a `.` (dot)
  instead of `@` (at) due to the special meaning the `@` has in zone files.\
  Strange as it may seem, `hostmaster.example2.test.` is the email address
  `hostmaster@example2.test` and not a subdomain.\
  For this reason, it's preferred to avoid emails containing `.` in the first
  part (before the `@`), however, this role will automatically escape any `.` in
  the first part of the email and use a `.` instead of `@`.
- **Fully qualified domain names (FQDNs) must end with a `.` (dot).**\
  For example, using `www.example2.test` (without `.` at the end) in a CNAME for
  the zone `example.test` would be interpreted as a subdomain, resulting in
  `www.example2.test.example.test`.\
  You can also use an FQDN for locally managed records (as we did for the CNAME
  `something`, using `www.example.test.` instead of simply using `www`), but I
  see no good reason to do so.

### TTL format

The time-to-live (TTL) is represented in seconds, but in BIND you can also use
time unit abbreviations.

| abbreviation | unit    | description        |
| :----------: | ------- | ------------------ |
|      s       | seconds | # x 1 seconds      |
|      m       | minutes | # x 60 seconds     |
|      h       | hours   | # x 3600 seconds   |
|      d       | day     | # x 86400 seconds  |
|      w       | week    | # x 604800 seconds |

You can find some examples for valid TTL values in the following table.

|    value |                       description | value in seconds |
| -------: | --------------------------------: | :--------------: |
|      30s |                        30 seconds |        30        |
|       5m |                         5 minutes |       300        |
|     100m |                       100 minutes |       6000       |
|       4h |                           4 hours |      14400       |
|      48h |                          48 hours |      172800      |
|       7d |                            7 days |      604800      |
|       2w |                           2 weeks |     1209600      |
|    2h30m |            2 hours and 30 minutes |       9000       |
| 4h15m30s | 4 hours 15 minutes and 30 seconds |      15330       |
|     2d4h |                2 days and 4 hours |      187200      |

**Note:** The TTL value is often constrained.\
For example, in theory the minimum value is `0` and the maximum value is `2147483647`
(approximately 68 years), but Bind9 sets the **minimum** for `refresh` and `retry`
to `300` (5 minutes) and the **minimum** for `expire` to `refresh + retry`, also
sets the **maximum** for `refresh` to `2419200` (4 weeks) and the **maximum** for
`retry` to `1209600` (2 weeks), and does something similar with other TTLs.
