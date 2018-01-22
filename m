Return-Path: virtio-dev-return-3005-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8182C58191E6
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Jan 2018 13:05:26 -0800 (PST)
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
 <CADGSJ22BsdB-hDb0xebSyWrwDuBJaFACjb26PDoqAd2Ah+tsQg@mail.gmail.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <a8dca7bc-75c8-e21e-a40e-f09d7b47c523@intel.com>
Date: Mon, 22 Jan 2018 13:05:15 -0800
MIME-Version: 1.0
In-Reply-To: <CADGSJ22BsdB-hDb0xebSyWrwDuBJaFACjb26PDoqAd2Ah+tsQg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend virtio to use VF
 datapath when available
To: Siwei Liu <loseweigh@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On 1/22/2018 12:27 PM, Siwei Liu wrote:
> First off, as mentioned in another thread, the model of stacking up
> virt-bond functionality over virtio seems a wrong direction to me.
> Essentially the migration process would need to carry over all guest
> side configurations previously done on the VF/PT and get them moved to
> the new device being it virtio or VF/PT. Without the help of a new
> upper layer bond driver that enslaves virtio and VF/PT devices
> underneath, virtio will be overloaded with too much specifics being a
> VF/PT backup in the future. I hope you're already aware of the issue
> in longer term and move to that model as soon as possible. See more
> inline.

The idea behind this design is to  provide a low latency datapath to 
virtio_net while
preserving live migration feature without the need for the guest admin 
to configure
a bond between VF and virtio_net.
As this feature is enabled and configured via virtio_net which has a 
back channel to
the hypervisor, adding this functionality to virtio_net looks like a 
reasonable option.

Adding a new driver and a new device requires defining a new interface 
and a channel
between the hypervisor and the VM and if required we may implement that in
future.

>
> On Thu, Jan 11, 2018 at 9:58 PM, Sridhar Samudrala
> <sridhar.samudrala@intel.com> wrote:
>> This patch enables virtio_net to switch over to a VF datapath when a VF
>> netdev is present with the same MAC address. The VF datapath is only used
>> for unicast traffic. Broadcasts/multicasts go via virtio datapath so that
>> east-west broadcasts don't use the PCI bandwidth.
> Why not making an this an option/optimization rather than being the
> only means? The problem of east-west broadcast eating PCI bandwidth
> depends on specifics of the (virtual) network setup, while some users
> won't want to lose VF's merits such as latency. Why restricting
> broadcast/multicast xmit to virtio only which potentially regresses
> the performance against raw VF?

I am planning to remove this option when i resubmit the patches.

>
>> It allows live migration
>> of a VM with a direct attached VF without the need to setup a bond/team
>> between a VF and virtio net device in the guest.
>>
>> The hypervisor needs to unplug the VF device from the guest on the source
>> host and reset the MAC filter of the VF to initiate failover of datapath to
>> virtio before starting the migration. After the migration is completed, the
>> destination hypervisor sets the MAC filter on the VF and plugs it back to
>> the guest to switch over to VF datapath.
> Is there a host side patch (planned) for this MAC filter switching
> process? As said in another thread, that simple script won't work for
> macvtap backend.

The host side patch to enable qemu to configure this feature is included 
in this patch
series.
I have been testing this feature using a shell script, but i hope 
someone in the libvirt
community  will extend 'virsh' to handle live migration when this 
feature is supported.

Thanks
Sridhar

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

