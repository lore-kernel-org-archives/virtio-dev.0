Return-Path: virtio-dev-return-5295-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00639985CB8
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Jan 2019 00:18:28 +0000 (UTC)
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
 <1546900184-27403-2-git-send-email-venu.busireddy@oracle.com>
 <6f5632f5-1469-7000-9b92-ef2564a63f63@oracle.com>
 <20190108172522.GA28457@troi>
 <41b85d40-0711-a0f3-6b45-bacd20644186@oracle.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <ae13f571-8359-24bb-a24f-cb5727a9623a@intel.com>
Date: Tue, 8 Jan 2019 16:18:24 -0800
MIME-Version: 1.0
In-Reply-To: <41b85d40-0711-a0f3-6b45-bacd20644186@oracle.com>
Content-Type: multipart/alternative;
 boundary="------------9746C77545968D3E1E13EF20"
Content-Language: en-US
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v3 1/5] virtio_net: Add VIRTIO_NET_F_STANDBY
 feature bit.
To: Dongli Zhang <dongli.zhang@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, si-wei.liu@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------9746C77545968D3E1E13EF20
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

On 1/8/2019 4:14 PM, Dongli Zhang wrote:
> Hi Venu,
>
> On 2019/1/9 上午1:25, Venu Busireddy wrote:
>> On 2019-01-09 00:56:38 +0800, Dongli Zhang wrote:
>>> I am not familiar with libvirt and I would like to play with this only with qemu.
>>>
>>> With failover, we need to hotplug the VF on destination server to VM after live
>>> migration. However, the VF on destination server would have different mac address.
>>>
>>> How can we specify the mac for the new VF to hotplug via qemu, as VF is only a
>>> vfio pci device?
>> How is the VF device on the destination host any different from the VF
>> on the source host?
>>
>> As you do on the source host, you first assign the MAC address of
>> 00:00:00:00:00:00 to the VF. After the migration, you assign the same
>> MAC address as that of the virtio_net device to the VF, and hotadd the VF
> This was what I was wondering.
>
> How the mac address is configured for VF (or any NIC like PF) after it is
> assigned to vfio?

ip link set <pf> vf  <vf-num>  mac <MAC>

See https://www.kernel.org/doc/html/latest/networking/net_failover.html
for a sample script that shows the steps to initiate live migration with VF
and virtio-net in standby mode.


>
> Thank you very much!
>
> Dongli Zhang
>
>
>> device to the VM. And then, after you receive the FAILOVER_PRIMARY_CHANGED
>> event, set the macvtap device to down state.
>>
>> Venu
>>
>>> I am trying to play with this with only qemu (w/o libvirt).
>>>
>>> Thank you very much!
>>>
>>> Dongli Zhang
>>>
>>> On 01/08/2019 06:29 AM, Venu Busireddy wrote:
>>>> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>>
>>>> This feature bit can be used by a hypervisor to indicate to the virtio_net
>>>> device that it can act as a standby for another device with the same MAC
>>>> address.
>>>>
>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>> Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
>>>> ---
>>>>   hw/net/virtio-net.c | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>> index 385b1a0..411f8fb 100644
>>>> --- a/hw/net/virtio-net.c
>>>> +++ b/hw/net/virtio-net.c
>>>> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
>>>>                        true),
>>>>       DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>>>>       DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>>>> +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
>>>> +                      false),
>>>>       DEFINE_PROP_END_OF_LIST(),
>>>>   };
>>>>   
>>>>

--------------9746C77545968D3E1E13EF20
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 1/8/2019 4:14 PM, Dongli Zhang
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:41b85d40-0711-a0f3-6b45-bacd20644186@oracle.com">
      <pre class="moz-quote-pre" wrap="">Hi Venu,

On 2019/1/9 上午1:25, Venu Busireddy wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 2019-01-09 00:56:38 +0800, Dongli Zhang wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">I am not familiar with libvirt and I would like to play with this only with qemu.

With failover, we need to hotplug the VF on destination server to VM after live
migration. However, the VF on destination server would have different mac address.

How can we specify the mac for the new VF to hotplug via qemu, as VF is only a
vfio pci device?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
How is the VF device on the destination host any different from the VF
on the source host?

As you do on the source host, you first assign the MAC address of
00:00:00:00:00:00 to the VF. After the migration, you assign the same
MAC address as that of the virtio_net device to the VF, and hotadd the VF
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This was what I was wondering.

How the mac address is configured for VF (or any NIC like PF) after it is
assigned to vfio?</pre>
    </blockquote>
    <pre>ip link set &lt;pf&gt; vf  &lt;vf-num&gt;  mac &lt;MAC&gt;</pre>
    <pre>See <a class="moz-txt-link-freetext" href="https://www.kernel.org/doc/html/latest/networking/net_failover.html">https://www.kernel.org/doc/html/latest/networking/net_failover.html</a>
for a sample script that shows the steps to initiate live migration with VF 
and virtio-net in standby mode.
</pre>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:41b85d40-0711-a0f3-6b45-bacd20644186@oracle.com">
      <pre class="moz-quote-pre" wrap="">

Thank you very much!

Dongli Zhang


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">device to the VM. And then, after you receive the FAILOVER_PRIMARY_CHANGED
event, set the macvtap device to down state.

Venu

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
I am trying to play with this with only qemu (w/o libvirt).

Thank you very much!

Dongli Zhang

On 01/08/2019 06:29 AM, Venu Busireddy wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">From: Sridhar Samudrala <a class="moz-txt-link-rfc2396E" href="mailto:sridhar.samudrala@intel.com">&lt;sridhar.samudrala@intel.com&gt;</a>

This feature bit can be used by a hypervisor to indicate to the virtio_net
device that it can act as a standby for another device with the same MAC
address.

Signed-off-by: Sridhar Samudrala <a class="moz-txt-link-rfc2396E" href="mailto:sridhar.samudrala@intel.com">&lt;sridhar.samudrala@intel.com&gt;</a>
Signed-off-by: Venu Busireddy <a class="moz-txt-link-rfc2396E" href="mailto:venu.busireddy@oracle.com">&lt;venu.busireddy@oracle.com&gt;</a>
---
 hw/net/virtio-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 385b1a0..411f8fb 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
                      true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
+    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
+                      false),
     DEFINE_PROP_END_OF_LIST(),
 };
 

</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------9746C77545968D3E1E13EF20--
