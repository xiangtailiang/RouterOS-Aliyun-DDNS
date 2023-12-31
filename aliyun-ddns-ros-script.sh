:local id "aliyun-id";

:local secret "aliyun-secret";

:local PPPOE "pppoe-out1";

:local domain yourdomain.xyz;
:local record @;

:local ddnsLine "default";

:local ttl 600;

:local dnsIP;
:do {
  :set dnsIP [:resolve "$record.$domain"];
} on-error={
  :set dnsIP "";
}

:local IPv4 [/ip address get [find interface=$PPPOE] address];
:set IPv4 [:pick $IPv4 0 [:find $IPv4 "/"]];

:if ($dnsIP != $IPv4) do={
  :local result [/tool fetch http-method=post http-data="{\"id\":\"$id\",\"secret\":\"$secret\",\"domain\":\"$domain\",\"record\":\"$record\",\"ip\":\"$IPv4\",\"type\":\"A\",\"ttl\":\"$ttl\",\"line\":\"$ddnsLine\"}" url="https://aliyun-ddns-aliyun-ddns-lvygdltxuj.cn-hangzhou.fcapp.run" check-certificate=no as-value output=user];
  :if ($result->"status" = "finished") do={
    :if ($result->"data" = "0") do={
      :log info "aliDDNS:IPv4 update ok! IPv4: $IPv4";
    } else {
      :if ($result->"data" = "2") do={
        :log warning "aliDDNS:IPv4 not change! IPv4: $IPv4";
      } else {
        :log error "aliDDNS:IPv4 update error";
      }
    }
  }
}