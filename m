Return-Path: virtio-dev-return-5313-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61D13985DBD
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 Jan 2019 06:57:33 +0000 (UTC)
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
 <20190107182604-mutt-send-email-mst@kernel.org>
 <7f230258-0950-9155-ec9c-6c6102ed2c2b@oracle.com>
 <20190107212122-mutt-send-email-mst@kernel.org>
 <96c1a360-3c21-a4ed-83ea-f094eeaf3b7c@oracle.com>
 <20190109083137-mutt-send-email-mst@kernel.org>
From: si-wei liu <si-wei.liu@oracle.com>
Message-ID: <0b89ff8d-c1d0-6a37-21c6-58bed6d2f5ae@oracle.com>
Date: Thu, 10 Jan 2019 22:57:28 -0800
MIME-Version: 1.0
In-Reply-To: <20190109083137-mutt-send-email-mst@kernel.org>
Content-Type: multipart/alternative;
 boundary="------------22FA898212636E9CCE82A0BD"
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v3 0/5] Support for datapath switching
 during live migration
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Liran Alon <liran.alon@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--------------22FA898212636E9CCE82A0BD
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit



On 01/09/2019 05:39 AM, Michael S. Tsirkin wrote:
> On Tue, Jan 08, 2019 at 08:55:35PM -0800, si-wei liu wrote:
>>
>> On 1/7/2019 6:25 PM, Michael S. Tsirkin wrote:
>>
>>      On Mon, Jan 07, 2019 at 05:45:22PM -0800, si-wei liu wrote:
>>
>>          On 01/07/2019 03:32 PM, Michael S. Tsirkin wrote:
>>
>>              On Mon, Jan 07, 2019 at 05:29:39PM -0500, Venu Busireddy wrote:
>>
>>                  Implement the infrastructure to support datapath switching during live
>>                  migration involving SR-IOV devices.
>>
>>                  1. This patch is based off on the current VIRTIO_NET_F_STANDBY feature
>>                      bit and MAC address device pairing.
>>
>>                  2. This set of events will be consumed by userspace management software
>>                      to orchestrate all the hot plug and datapath switching activities.
>>                      This scheme has the least QEMU modifications while allowing userspace
>>                      software to build its own intelligence to control the whole process
>>                      of SR-IOV live migration.
>>
>>                  3. While the hidden device model (viz. coupled device model) is still
>>                      being explored for automatic hot plugging (QEMU) and automatic datapath
>>                      switching (host-kernel), this series provides a supplemental set
>>                      of interfaces if management software wants to drive the SR-IOV live
>>                      migration on its own. It should not conflict with the hidden device
>>                      model but just offers simplicity of implementation.
>> And if guest*does*  need the switch because e.g. attaching xdp wants to
>> resent the card?
>>
>>
>>
>>                  Si-Wei Liu (2):
>>                     vfio-pci: Add FAILOVER_PRIMARY_CHANGED event to shorten downtime during failover
>>                     pci: query command extension to check the bus master enabling status of the failover-primary device
>>
>>                  Sridhar Samudrala (1):
>>                     virtio_net: Add VIRTIO_NET_F_STANDBY feature bit.
>>
>>                  Venu Busireddy (2):
>>                     virtio_net: Add support for "Data Path Switching" during Live Migration.
>>                     virtio_net: Add a query command for FAILOVER_STANDBY_CHANGED event.
>>
>>                  ---
>>                  Changes in v3:
>>                     Fix issues with coding style in patch 3/5.
>>
>>                  Changes in v2:
>>                     Added a query command for FAILOVER_STANDBY_CHANGED event.
>>                     Added a query command for FAILOVER_PRIMARY_CHANGED event.
>>
>>              Hmm it looks like all feedback I sent e.g. here:
>>              https://patchwork.kernel.org/patch/10721571/
>>              got ignored.
>>
>>              To summarize I suggest reworking the series adding a new command along
>>              the lines of (naming is up to you):
>>
>>              query-pci-master - this returns status for a device
>>                                 and enables a *single* event after
>>                                 it changes
>>
>>              and then removing all status data from the event,
>>              just notify about the change and *only once*.
>>
>>          Why removing all status data from the event?
>>
>>      To make sure users do not forget to call query-pci-master to
>>      re-enable more events.
>>
>> IMO the FAILOVER_PRIMARY_CHANGED event is on the performance path, it's an
>> overkill to enforce round trip query for each event in normal situations.
>>
>>          It does not hurt to keep them
>>          as the FAILOVER_PRIMARY_CHANGED event in general is of pretty low-frequency.
>>
>>      A malicious guest can make it as frequent as it wants to.
>>      OTOH there is no way to limit.
>>
>> Will throttle the event rate (say, limiting to no more than 1 event per second)
> And if guest *does* need the switch because e.g. attaching xdp wants to
> resent the card?
Device reset during attaching XDP prog doesn't end up with PCI master 
status reset as far as I see. Even so (say with FLR or slot reset), the 
ending state would be reflected (without having to do a query) if 
state's going through quick transitions. And, suppressing event emission 
until next query seems to make management stack perform worse in this 
case? Management stack end up having to query commands for couple of 
times to see if status is settled.

>
>> a way to limit (as opposed to control guest behavior) ? The other similar
>> events that apply rate limiting don't suppress event emission until the next
>> query at all.
> We have some problematic interfaces already, that's true.
>
>> Doing so would just cause more events missing. As stated in the
>> earlier example, we should give guest NIC a chance to flush queued packets even
>> if ending state is same between two events.
> I haven't seen that requirement. I guess a reset just stops processing
> buffers rather than flush. Care to repeat?
If for some reason a VF driver runs into some hardware/firmware fault 
and keeps resetting just attempts to fix itself, wouldn't it be 
necessary for failover to use the PV path temporarily? Without proper 
interleaving all packets can be dropped in the worst case. Severe packet 
drops deteriorate network performance quite badly, and may even lead to 
fatal errors if storage device is being hosted over the network (e.g. 
iSCSI) in particular.

>
>>          As can be seen other similar low-frequent QMP events do have data carried
>>          over.
>>
>>          As this event relates to datapath switching, there's implication to coalesce
>>          events as packets might not get a chance to send out as nothing would ever
>>          happen when  going through quick transitions like
>>          disabled->enabled->disabled. I would allow at least few packets to be sent
>>          over wire rather than nothing. Who knows how fast management can react and
>>          consume these events?
>>
>>          Thanks,
>>          -Siwei
>>
>>      OK if it's so important for latency let's include data in the event.
>>      Please add comments explaining that you must always re-run query
>>      afterwards to make sure it's stable and re-enable more events.
>>
>> I can add comments describing why we need to carry data in the event, and apply
>> rate limiting to events. But I don't follow why it must suppress event until
>> next query.
> Rate limiting is fundamentally broken.
What is the issue with rate limiting? Seems pretty good fit to me, as 
otherwise mgmt stack still need to check the status periodically with 
some slow rate if experiencing malicious attack.
> Try a stress of resets and there goes your promise of low downtime.
Is this a normal user would do? I guess only malicious guest may do so. 
With this in mind, what's more important is to defend the attack by 
imposing rate limiter, and downtime is not even a factor to consider in 
this context. The point is that I view rate limiting as a way to defend 
malicious attack, and it's a good trade-off as reset itself doesn't 
happen very often in normal situations. And we can always find a proper 
rate that could balance both needs well.

BTW, there's no way to promise latency/downtime either way - all is 
based on best effort with the current datapatch switching scheme that 
involves userspace management stack. IMHO ideally the only way with some 
latency/downtime guarantee is to have guest to kick off datapath 
switching through a control queue message, which would cause guest to 
exit and host kernel would then take the turn to handle the MAC filter 
movement in a synchronized context. Or we should wait Intel to fix their 
legacy drivers.

>
> Let me try to re-state: state query is fundamentally required
> because otherwise e.g. management restarts do not work.
Yes, we've added the query command for such purpose (handle management 
restarts). There's no argue about this.

> And it is much better to force management to run query every event
> and every restart than just hope it handles racy corner cases correctly.
There's no way to handle those racy corner cases with what you 
suggested, I see missing packets when switching promiscuous mode on 
virtio-net, and I see no chance it can be improved with the current scheme.

>
> If we do include data in the event then there is no real latency cost to
> that, since management can take action in response to the event then do
> the query asynchronously at leasure.
> So let me turn it around and say I don't follow why you have objections
> to blocking following events until query.
See my explanations above.

thanks,
-Siwei
>
>
>> Thanks,
>> -Siwei
>>
>>
>>
>>
>>
>>
>>
>>              upon event management does query-pci-master
>>              and acts accordingly.
>>
>>
>>
>>
>>
>>                    hmp.c                          |   5 +++
>>                    hw/acpi/pcihp.c                |  27 +++++++++++
>>                    hw/net/virtio-net.c            |  42 +++++++++++++++++
>>                    hw/pci/pci.c                   |   5 +++
>>                    hw/vfio/pci.c                  |  60 +++++++++++++++++++++++++
>>                    hw/vfio/pci.h                  |   1 +
>>                    include/hw/pci/pci.h           |   1 +
>>                    include/hw/virtio/virtio-net.h |   1 +
>>                    include/net/net.h              |   2 +
>>                    net/net.c                      |  61 +++++++++++++++++++++++++
>>                    qapi/misc.json                 |   5 ++-
>>                    qapi/net.json                  | 100 +++++++++++++++++++++++++++++++++++++++++
>>                    12 files changed, 309 insertions(+), 1 deletion(-)
>>
>>              ---------------------------------------------------------------------
>>              To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>              For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
>>
>>      ---------------------------------------------------------------------
>>      To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>      For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
>>
>>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


--------------22FA898212636E9CCE82A0BD
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 01/09/2019 05:39 AM, Michael S.
      Tsirkin wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20190109083137-mutt-send-email-mst@kernel.org">
      <pre wrap="">On Tue, Jan 08, 2019 at 08:55:35PM -0800, si-wei liu wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">

On 1/7/2019 6:25 PM, Michael S. Tsirkin wrote:

    On Mon, Jan 07, 2019 at 05:45:22PM -0800, si-wei liu wrote:

        On 01/07/2019 03:32 PM, Michael S. Tsirkin wrote:

            On Mon, Jan 07, 2019 at 05:29:39PM -0500, Venu Busireddy wrote:

                Implement the infrastructure to support datapath switching during live
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
And if guest <b class="moz-txt-star"><span class="moz-txt-tag">*</span>does<span class="moz-txt-tag">*</span></b> need the switch because e.g. attaching xdp wants to
resent the card?



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

            Hmm it looks like all feedback I sent e.g. here:
            <a class="moz-txt-link-freetext" href="https://patchwork.kernel.org/patch/10721571/">https://patchwork.kernel.org/patch/10721571/</a>
            got ignored.

            To summarize I suggest reworking the series adding a new command along
            the lines of (naming is up to you):

            query-pci-master - this returns status for a device
                               and enables a *single* event after
                               it changes

            and then removing all status data from the event,
            just notify about the change and *only once*.

        Why removing all status data from the event?

    To make sure users do not forget to call query-pci-master to
    re-enable more events.

IMO the FAILOVER_PRIMARY_CHANGED event is on the performance path, it's an
overkill to enforce round trip query for each event in normal situations.

        It does not hurt to keep them
        as the FAILOVER_PRIMARY_CHANGED event in general is of pretty low-frequency.

    A malicious guest can make it as frequent as it wants to.
    OTOH there is no way to limit.

Will throttle the event rate (say, limiting to no more than 1 event per second)
</pre>
      </blockquote>
      <pre wrap="">
And if guest *does* need the switch because e.g. attaching xdp wants to
resent the card?</pre>
    </blockquote>
    Device reset during attaching XDP prog doesn't end up with PCI
    master status reset as far as I see. Even so (say with FLR or slot
    reset), the ending state would be reflected (without having to do a
    query) if state's going through quick transitions. And, suppressing
    event emission until next query seems to make management stack
    perform worse in this case? Management stack end up having to query
    commands for couple of times to see if status is settled.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20190109083137-mutt-send-email-mst@kernel.org">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">a way to limit (as opposed to control guest behavior) ? The other similar
events that apply rate limiting don't suppress event emission until the next
query at all.
</pre>
      </blockquote>
      <pre wrap="">
We have some problematic interfaces already, that's true.

</pre>
      <blockquote type="cite">
        <pre wrap="">Doing so would just cause more events missing. As stated in the
earlier example, we should give guest NIC a chance to flush queued packets even
if ending state is same between two events.
</pre>
      </blockquote>
      <pre wrap="">
I haven't seen that requirement. I guess a reset just stops processing
buffers rather than flush. Care to repeat?</pre>
    </blockquote>
    If for some reason a VF driver runs into some hardware/firmware
    fault and keeps resetting just attempts to fix itself, wouldn't it
    be necessary for failover to use the PV path temporarily? Without
    proper interleaving all packets can be dropped in the worst case.
    Severe packet drops deteriorate network performance quite badly, and
    may even lead to fatal errors if storage device is being hosted over
    the network (e.g. iSCSI) in particular.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20190109083137-mutt-send-email-mst@kernel.org">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">
        As can be seen other similar low-frequent QMP events do have data carried
        over.

        As this event relates to datapath switching, there's implication to coalesce
        events as packets might not get a chance to send out as nothing would ever
        happen when  going through quick transitions like
        disabled-&gt;enabled-&gt;disabled. I would allow at least few packets to be sent
        over wire rather than nothing. Who knows how fast management can react and
        consume these events?

        Thanks,
        -Siwei

    OK if it's so important for latency let's include data in the event.
    Please add comments explaining that you must always re-run query
    afterwards to make sure it's stable and re-enable more events.

I can add comments describing why we need to carry data in the event, and apply
rate limiting to events. But I don't follow why it must suppress event until
next query.
</pre>
      </blockquote>
      <pre wrap="">
Rate limiting is fundamentally broken.</pre>
    </blockquote>
    What is the issue with rate limiting? Seems pretty good fit to me,
    as otherwise mgmt stack still need to check the status periodically
    with some slow rate if experiencing malicious attack. <br>
    <blockquote type="cite"
      cite="mid:20190109083137-mutt-send-email-mst@kernel.org">
      <pre wrap="">
Try a stress of resets and there goes your promise of low downtime.</pre>
    </blockquote>
    Is this a normal user would do? I guess only malicious guest may do
    so. With this in mind, what's more important is to defend the attack
    by imposing rate limiter, and downtime is not even a factor to
    consider in this context. The point is that I view rate limiting as
    a way to defend malicious attack, and it's a good trade-off as reset
    itself doesn't happen very often in normal situations. And we can
    always find a proper rate that could balance both needs well.<br>
    <br>
    BTW, there's no way to promise latency/downtime either way - all is
    based on best effort with the current datapatch switching scheme
    that involves userspace management stack. IMHO ideally the only way
    with some latency/downtime guarantee is to have guest to kick off
    datapath switching through a control queue message, which would
    cause guest to exit and host kernel would then take the turn to
    handle the MAC filter movement in a synchronized context. Or we
    should wait Intel to fix their legacy drivers.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20190109083137-mutt-send-email-mst@kernel.org">
      <pre wrap="">

Let me try to re-state: state query is fundamentally required
because otherwise e.g. management restarts do not work.</pre>
    </blockquote>
    Yes, we've added the query command for such purpose (handle
    management restarts). There's no argue about this.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20190109083137-mutt-send-email-mst@kernel.org">
      <pre wrap="">
And it is much better to force management to run query every event
and every restart than just hope it handles racy corner cases correctly.</pre>
    </blockquote>
    There's no way to handle those racy corner cases with what you
    suggested, I see missing packets when switching promiscuous mode on
    virtio-net, and I see no chance it can be improved with the current
    scheme.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20190109083137-mutt-send-email-mst@kernel.org">
      <pre wrap="">

If we do include data in the event then there is no real latency cost to
that, since management can take action in response to the event then do
the query asynchronously at leasure.
So let me turn it around and say I don't follow why you have objections
to blocking following events until query.</pre>
    </blockquote>
    See my explanations above.<br>
    <br>
    thanks,<br>
    -Siwei<br>
    <blockquote type="cite"
      cite="mid:20190109083137-mutt-send-email-mst@kernel.org">
      <pre wrap="">


</pre>
      <blockquote type="cite">
        <pre wrap="">
Thanks,
-Siwei







            upon event management does query-pci-master
            and acts accordingly.





                  hmp.c                          |   5 +++
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

            ---------------------------------------------------------------------
            To unsubscribe, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-unsubscribe@lists.oasis-open.org">virtio-dev-unsubscribe@lists.oasis-open.org</a>
            For additional commands, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-help@lists.oasis-open.org">virtio-dev-help@lists.oasis-open.org</a>


    ---------------------------------------------------------------------
    To unsubscribe, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-unsubscribe@lists.oasis-open.org">virtio-dev-unsubscribe@lists.oasis-open.org</a>
    For additional commands, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-help@lists.oasis-open.org">virtio-dev-help@lists.oasis-open.org</a>



</pre>
      </blockquote>
      <pre wrap="">
---------------------------------------------------------------------
To unsubscribe, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-unsubscribe@lists.oasis-open.org">virtio-dev-unsubscribe@lists.oasis-open.org</a>
For additional commands, e-mail: <a class="moz-txt-link-abbreviated" href="mailto:virtio-dev-help@lists.oasis-open.org">virtio-dev-help@lists.oasis-open.org</a>

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------22FA898212636E9CCE82A0BD--
