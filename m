Return-Path: virtio-dev-return-5297-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABCEB985CB8
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Jan 2019 04:55:39 +0000 (UTC)
From: si-wei liu <si-wei.liu@oracle.com>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
 <20190107182604-mutt-send-email-mst@kernel.org>
 <7f230258-0950-9155-ec9c-6c6102ed2c2b@oracle.com>
 <20190107212122-mutt-send-email-mst@kernel.org>
Message-ID: <96c1a360-3c21-a4ed-83ea-f094eeaf3b7c@oracle.com>
Date: Tue, 8 Jan 2019 20:55:35 -0800
MIME-Version: 1.0
In-Reply-To: <20190107212122-mutt-send-email-mst@kernel.org>
Content-Type: multipart/alternative;
 boundary="------------04A6C2BF262D2D6CF8BAB9CB"
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v3 0/5] Support for datapath switching
 during live migration
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Liran Alon <liran.alon@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--------------04A6C2BF262D2D6CF8BAB9CB
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit



On 1/7/2019 6:25 PM, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 05:45:22PM -0800, si-wei liu wrote:
>> On 01/07/2019 03:32 PM, Michael S. Tsirkin wrote:
>>> On Mon, Jan 07, 2019 at 05:29:39PM -0500, Venu Busireddy wrote:
>>>> Implement the infrastructure to support datapath switching during live
>>>> migration involving SR-IOV devices.
>>>>
>>>> 1. This patch is based off on the current VIRTIO_NET_F_STANDBY feature
>>>>      bit and MAC address device pairing.
>>>>
>>>> 2. This set of events will be consumed by userspace management software
>>>>      to orchestrate all the hot plug and datapath switching activities.
>>>>      This scheme has the least QEMU modifications while allowing userspace
>>>>      software to build its own intelligence to control the whole process
>>>>      of SR-IOV live migration.
>>>>
>>>> 3. While the hidden device model (viz. coupled device model) is still
>>>>      being explored for automatic hot plugging (QEMU) and automatic datapath
>>>>      switching (host-kernel), this series provides a supplemental set
>>>>      of interfaces if management software wants to drive the SR-IOV live
>>>>      migration on its own. It should not conflict with the hidden device
>>>>      model but just offers simplicity of implementation.
>>>>
>>>>
>>>> Si-Wei Liu (2):
>>>>     vfio-pci: Add FAILOVER_PRIMARY_CHANGED event to shorten downtime during failover
>>>>     pci: query command extension to check the bus master enabling status of the failover-primary device
>>>>
>>>> Sridhar Samudrala (1):
>>>>     virtio_net: Add VIRTIO_NET_F_STANDBY feature bit.
>>>>
>>>> Venu Busireddy (2):
>>>>     virtio_net: Add support for "Data Path Switching" during Live Migration.
>>>>     virtio_net: Add a query command for FAILOVER_STANDBY_CHANGED event.
>>>>
>>>> ---
>>>> Changes in v3:
>>>>     Fix issues with coding style in patch 3/5.
>>>>
>>>> Changes in v2:
>>>>     Added a query command for FAILOVER_STANDBY_CHANGED event.
>>>>     Added a query command for FAILOVER_PRIMARY_CHANGED event.
>>> Hmm it looks like all feedback I sent e.g. here:
>>> https://patchwork.kernel.org/patch/10721571/
>>> got ignored.
>>>
>>> To summarize I suggest reworking the series adding a new command along
>>> the lines of (naming is up to you):
>>>
>>> query-pci-master - this returns status for a device
>>> 		   and enables a *single* event after
>>> 		   it changes
>>>
>>> and then removing all status data from the event,
>>> just notify about the change and *only once*.
>> Why removing all status data from the event?
> To make sure users do not forget to call query-pci-master to
> re-enable more events.
IMO the FAILOVER_PRIMARY_CHANGED event is on the performance path, it's 
an overkill to enforce round trip query for each event in normal situations.
>> It does not hurt to keep them
>> as the FAILOVER_PRIMARY_CHANGED event in general is of pretty low-frequency.
> A malicious guest can make it as frequent as it wants to.
> OTOH there is no way to limit.
Will throttle the event rate (say, limiting to no more than 1 event per 
second) a way to limit (as opposed to control guest behavior) ? The 
other similar events that apply rate limiting don't suppress event 
emission until the next query at all. Doing so would just cause more 
events missing. As stated in the earlier example, we should give guest 
NIC a chance to flush queued packets even if ending state is same 
between two events.

>> As can be seen other similar low-frequent QMP events do have data carried
>> over.
>>
>> As this event relates to datapath switching, there's implication to coalesce
>> events as packets might not get a chance to send out as nothing would ever
>> happen when  going through quick transitions like
>> disabled->enabled->disabled. I would allow at least few packets to be sent
>> over wire rather than nothing. Who knows how fast management can react and
>> consume these events?
>>
>> Thanks,
>> -Siwei
> OK if it's so important for latency let's include data in the event.
> Please add comments explaining that you must always re-run query
> afterwards to make sure it's stable and re-enable more events.
I can add comments describing why we need to carry data in the event, 
and apply rate limiting to events. But I don't follow why it must 
suppress event until next query.


Thanks,
-Siwei

>
>
>>> 	
>>>
>>> upon event management does query-pci-master
>>> and acts accordingly.
>>>
>>>
>>>
>>>
>>>>    hmp.c                          |   5 +++
>>>>    hw/acpi/pcihp.c                |  27 +++++++++++
>>>>    hw/net/virtio-net.c            |  42 +++++++++++++++++
>>>>    hw/pci/pci.c                   |   5 +++
>>>>    hw/vfio/pci.c                  |  60 +++++++++++++++++++++++++
>>>>    hw/vfio/pci.h                  |   1 +
>>>>    include/hw/pci/pci.h           |   1 +
>>>>    include/hw/virtio/virtio-net.h |   1 +
>>>>    include/net/net.h              |   2 +
>>>>    net/net.c                      |  61 +++++++++++++++++++++++++
>>>>    qapi/misc.json                 |   5 ++-
>>>>    qapi/net.json                  | 100 +++++++++++++++++++++++++++++++++++++++++
>>>>    12 files changed, 309 insertions(+), 1 deletion(-)
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail:virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail:virtio-dev-help@lists.oasis-open.org
>>>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail:virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail:virtio-dev-help@lists.oasis-open.org
>


--------------04A6C2BF262D2D6CF8BAB9CB
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 1/7/2019 6:25 PM, Michael S. Tsirkin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20190107212122-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">On Mon, Jan 07, 2019 at 05:45:22PM -0800, si-wei liu wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
On 01/07/2019 03:32 PM, Michael S. Tsirkin wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Mon, Jan 07, 2019 at 05:29:39PM -0500, Venu Busireddy wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Implement the infrastructure to support datapath switching during live
migration involving SR-IOV devices.

1. This patch is based off on the current VIRTIO_NET_F_STANDBY feature
    bit and MAC address device pairing.

2. This set of events will be consumed by userspace management software
    to orchestrate all the hot plug and datapath switching activities.
    This scheme has the least QEMU modifications while allowing userspace
    software to build its own intelligence to control the whole process
    of SR-IOV live migration.

3. While the hidden device model (viz. coupled device model) is still
    being explored for automatic hot plugging (QEMU) and automatic datapath
    switching (host-kernel), this series provides a supplemental set
    of interfaces if management software wants to drive the SR-IOV live
    migration on its own. It should not conflict with the hidden device
    model but just offers simplicity of implementation.


Si-Wei Liu (2):
   vfio-pci: Add FAILOVER_PRIMARY_CHANGED event to shorten downtime during failover
   pci: query command extension to check the bus master enabling status of the failover-primary device

Sridhar Samudrala (1):
   virtio_net: Add VIRTIO_NET_F_STANDBY feature bit.

Venu Busireddy (2):
   virtio_net: Add support for "Data Path Switching" during Live Migration.
   virtio_net: Add a query command for FAILOVER_STANDBY_CHANGED event.

---
Changes in v3:
   Fix issues with coding style in patch 3/5.

Changes in v2:
   Added a query command for FAILOVER_STANDBY_CHANGED event.
   Added a query command for FAILOVER_PRIMARY_CHANGED event.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Hmm it looks like all feedback I sent e.g. here:
<a class="moz-txt-link-freetext" href="https://patchwork.kernel.org/patch/10721571/">https://patchwork.kernel.org/patch/10721571/</a>
got ignored.

To summarize I suggest reworking the series adding a new command along
the lines of (naming is up to you):

query-pci-master - this returns status for a device
		   and enables a *single* event after
		   it changes

and then removing all status data from the event,
just notify about the change and *only once*.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Why removing all status data from the event?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">To make sure users do not forget to call query-pci-master to
re-enable more events.</pre>
    </blockquote>
    IMO the FAILOVER_PRIMARY_CHANGED event is on the performance path,
    it's an overkill to enforce round trip query for each event in
    normal situations.<br>
    <blockquote type="cite"
      cite="mid:20190107212122-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">It does not hurt to keep them
as the FAILOVER_PRIMARY_CHANGED event in general is of pretty low-frequency.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">A malicious guest can make it as frequent as it wants to.
OTOH there is no way to limit.</pre>
    </blockquote>
    Will throttle the event rate (say, limiting to no more than 1 event
    per second) a way to limit (as opposed to control guest behavior) ?
    The other similar events that apply rate limiting don't suppress
    event emission until the next query at all. Doing so would just
    cause more events missing. As stated in the earlier example, we
    should give guest NIC a chance to flush queued packets even if
    ending state is same between two events.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20190107212122-mutt-send-email-mst@kernel.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">As can be seen other similar low-frequent QMP events do have data carried
over.

As this event relates to datapath switching, there's implication to coalesce
events as packets might not get a chance to send out as nothing would ever
happen when  going through quick transitions like
disabled-&gt;enabled-&gt;disabled. I would allow at least few packets to be sent
over wire rather than nothing. Who knows how fast management can react and
consume these events?

Thanks,
-Siwei
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">OK if it's so important for latency let's include data in the event.
Please add comments explaining that you must always re-run query
afterwards to make sure it's stable and re-enable more events.</pre>
    </blockquote>
    I can add comments describing why we need to carry data in the
    event, and apply rate limiting to events. But I don't follow why it
    must suppress event until next query.<br>
    <br>
    <br>
    Thanks,<br>
    -Siwei<br>
    <br>
    <blockquote type="cite"
      cite="mid:20190107212122-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">


</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">	

upon event management does query-pci-master
and acts accordingly.




</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">  hmp.c                          |   5 +++
  hw/acpi/pcihp.c                |  27 +++++++++++
  hw/net/virtio-net.c            |  42 +++++++++++++++++
  hw/pci/pci.c                   |   5 +++
  hw/vfio/pci.c                  |  60 +++++++++++++++++++++++++
  hw/vfio/pci.h                  |   1 +
  include/hw/pci/pci.h           |   1 +
  include/hw/virtio/virtio-net.h |   1 +
  include/net/net.h              |   2 +
  net/net.c                      |  61 +++++++++++++++++++++++++
  qapi/misc.json                 |   5 ++-
  qapi/net.json                  | 100 +++++++++++++++++++++++++++++++++++++++++
  12 files changed, 309 insertions(+), 1 deletion(-)
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">---------------------------------------------------------------------
To unsubscribe, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-unsubscribe@lists.oasis-open.org">virtio-dev-unsubscribe@lists.oasis-open.org</a>
For additional commands, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-help@lists.oasis-open.org">virtio-dev-help@lists.oasis-open.org</a>

</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">---------------------------------------------------------------------
To unsubscribe, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-unsubscribe@lists.oasis-open.org">virtio-dev-unsubscribe@lists.oasis-open.org</a>
For additional commands, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-help@lists.oasis-open.org">virtio-dev-help@lists.oasis-open.org</a>

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------04A6C2BF262D2D6CF8BAB9CB--
