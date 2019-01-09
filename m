Return-Path: virtio-dev-return-5296-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 437AC985CB8
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Jan 2019 04:17:41 +0000 (UTC)
Date: Tue, 8 Jan 2019 23:17:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190108231551-mutt-send-email-mst@kernel.org>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
 <1546900184-27403-2-git-send-email-venu.busireddy@oracle.com>
 <6f5632f5-1469-7000-9b92-ef2564a63f63@oracle.com>
 <20190108172522.GA28457@troi>
 <41b85d40-0711-a0f3-6b45-bacd20644186@oracle.com>
 <ae13f571-8359-24bb-a24f-cb5727a9623a@intel.com>
 <17db1d06-f703-6ac6-57c7-0002eaf64a71@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17db1d06-f703-6ac6-57c7-0002eaf64a71@oracle.com>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v3 1/5] virtio_net: Add VIRTIO_NET_F_STANDBY
 feature bit.
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Venu Busireddy <venu.busireddy@oracle.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, si-wei.liu@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 09, 2019 at 08:39:07AM +0800, Dongli Zhang wrote:
> Hi Samudrala,
> 
> On 2019/1/9 上午8:18, Samudrala, Sridhar wrote:
> > On 1/8/2019 4:14 PM, Dongli Zhang wrote:
> >> Hi Venu,
> >>
> >> On 2019/1/9 上午1:25, Venu Busireddy wrote:
> >>> On 2019-01-09 00:56:38 +0800, Dongli Zhang wrote:
> >>>> I am not familiar with libvirt and I would like to play with this only with qemu.
> >>>>
> >>>> With failover, we need to hotplug the VF on destination server to VM after live
> >>>> migration. However, the VF on destination server would have different mac address.
> >>>>
> >>>> How can we specify the mac for the new VF to hotplug via qemu, as VF is only a
> >>>> vfio pci device?
> >>> How is the VF device on the destination host any different from the VF
> >>> on the source host?
> >>>
> >>> As you do on the source host, you first assign the MAC address of
> >>> 00:00:00:00:00:00 to the VF. After the migration, you assign the same
> >>> MAC address as that of the virtio_net device to the VF, and hotadd the VF
> >> This was what I was wondering.
> >>
> >> How the mac address is configured for VF (or any NIC like PF) after it is
> >> assigned to vfio?
> > 
> > ip link set <pf> vf  <vf-num>  mac <MAC>
> > 
> > See https://www.kernel.org/doc/html/latest/networking/net_failover.html
> > for a sample script that shows the steps to initiate live migration with VF 
> > and virtio-net in standby mode.
> 
> Thank you very much for the help!
> 
> Sorry that I did not ask the question in the right way.
> 
> Although I was talking about VF, I would like to passthrough the entire PF (with
> sriov_numvfs=0) to guest VM.
> 
> In this situation, I am not able to configure the mac address when the entire PF
> (or NIC) is assigned to VFIO. <pf> does not exist as it is belong to VFIO.
> 
> Thank you very much!
> 
> Dongli Zhang

I think that this mode isn't a good fit for the current (MAC address
based) failover. There was talk about supporting other ways to match
devices for failover, but no one implemented driver changes required
for this yet.


> > 
> > 
> >> Thank you very much!
> >>
> >> Dongli Zhang
> >>
> >>
> >>> device to the VM. And then, after you receive the FAILOVER_PRIMARY_CHANGED
> >>> event, set the macvtap device to down state.
> >>>
> >>> Venu
> >>>
> >>>> I am trying to play with this with only qemu (w/o libvirt).
> >>>>
> >>>> Thank you very much!
> >>>>
> >>>> Dongli Zhang
> >>>>
> >>>> On 01/08/2019 06:29 AM, Venu Busireddy wrote:
> >>>>> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >>>>>
> >>>>> This feature bit can be used by a hypervisor to indicate to the virtio_net
> >>>>> device that it can act as a standby for another device with the same MAC
> >>>>> address.
> >>>>>
> >>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >>>>> Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> >>>>> ---
> >>>>>  hw/net/virtio-net.c | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >>>>> index 385b1a0..411f8fb 100644
> >>>>> --- a/hw/net/virtio-net.c
> >>>>> +++ b/hw/net/virtio-net.c
> >>>>> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
> >>>>>                       true),
> >>>>>      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
> >>>>>      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> >>>>> +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
> >>>>> +                      false),
> >>>>>      DEFINE_PROP_END_OF_LIST(),
> >>>>>  };
> >>>>>  
> >>>>>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

