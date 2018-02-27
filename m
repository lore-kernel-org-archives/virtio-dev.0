Return-Path: virtio-dev-return-3306-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 834215819139
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Feb 2018 13:16:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180227084959.GB2005@nanopsycho>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
 <20180220104224.GA2031@nanopsycho> <CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
 <20180227084959.GB2005@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 27 Feb 2018 13:16:21 -0800
Message-ID: <CAKgT0Ucp8WhkORpVVy2VWwuvxZHZjXKn6YfHfVaLAVVybf3t5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jiri Pirko <jiri@resnulli.us>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 27, 2018 at 12:49 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Tue, Feb 20, 2018 at 05:04:29PM CET, alexander.duyck@gmail.com wrote:
>>On Tue, Feb 20, 2018 at 2:42 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Fri, Feb 16, 2018 at 07:11:19PM CET, sridhar.samudrala@intel.com wrote:
>>>>Patch 1 introduces a new feature bit VIRTIO_NET_F_BACKUP that can be
>>>>used by hypervisor to indicate that virtio_net interface should act as
>>>>a backup for another device with the same MAC address.
>>>>
>>>>Ppatch 2 is in response to the community request for a 3 netdev
>>>>solution.  However, it creates some issues we'll get into in a moment.
>>>>It extends virtio_net to use alternate datapath when available and
>>>>registered. When BACKUP feature is enabled, virtio_net driver creates
>>>>an additional 'bypass' netdev that acts as a master device and controls
>>>>2 slave devices.  The original virtio_net netdev is registered as
>>>>'backup' netdev and a passthru/vf device with the same MAC gets
>>>>registered as 'active' netdev. Both 'bypass' and 'backup' netdevs are
>>>>associated with the same 'pci' device.  The user accesses the network
>>>>interface via 'bypass' netdev. The 'bypass' netdev chooses 'active' netdev
>>>>as default for transmits when it is available with link up and running.
>>>
>>> Sorry, but this is ridiculous. You are apparently re-implemeting part
>>> of bonding driver as a part of NIC driver. Bond and team drivers
>>> are mature solutions, well tested, broadly used, with lots of issues
>>> resolved in the past. What you try to introduce is a weird shortcut
>>> that already has couple of issues as you mentioned and will certanly
>>> have many more. Also, I'm pretty sure that in future, someone comes up
>>> with ideas like multiple VFs, LACP and similar bonding things.
>>
>>The problem with the bond and team drivers is they are too large and
>>have too many interfaces available for configuration so as a result
>>they can really screw this interface up.
>>
>>Essentially this is meant to be a bond that is more-or-less managed by
>>the host, not the guest. We want the host to be able to configure it
>>and have it automatically kick in on the guest. For now we want to
>>avoid adding too much complexity as this is meant to be just the first
>>step. Trying to go in and implement the whole solution right from the
>>start based on existing drivers is going to be a massive time sink and
>>will likely never get completed due to the fact that there is always
>>going to be some other thing that will interfere.
>>
>>My personal hope is that we can look at doing a virtio-bond sort of
>>device that will handle all this as well as providing a communication
>>channel, but that is much further down the road. For now we only have
>>a single bit so the goal for now is trying to keep this as simple as
>>possible.
>
> I have another usecase that would require the solution to be different
> then what you suggest. Consider following scenario:
> - baremetal has 2 sr-iov nics
> - there is a vm, has 1 VF from each nics: vf0, vf1. No virtio_net
> - baremetal would like to somehow tell the VM to bond vf0 and vf1
>   together and how this bonding should be configured, according to how
>   the VF representors are configured on the baremetal (LACP for example)
>
> The baremetal could decide to remove any VF during the VM runtime, it
> can add another VF there. For migration, it can add virtio_net. The VM
> should be inctructed to bond all interfaces together according to how
> baremetal decided - as it knows better.
>
> For this we need a separate communication channel from baremetal to VM
> (perhaps something re-usable already exists), we need something to
> listen to the events coming from this channel (kernel/userspace) and to
> react accordingly (create bond/team, enslave, etc).
>
> Now the question is: is it possible to merge the demands you have and
> the generic needs I described into a single solution? From what I see,
> that would be quite hard/impossible. So at the end, I think that we have
> to end-up with 2 solutions:
> 1) virtio_net, netvsc in-driver bonding - very limited, stupid, 0config
>    solution that works for all (no matter what OS you use in VM)
> 2) team/bond solution with assistance of preferably userspace daemon
>    getting info from baremetal. This is not 0config, but minimal config
>    - user just have to define this "magic bonding" should be on.
>    This covers all possible usecases, including multiple VFs, RDMA, etc.
>
> Thoughts?

So that is about what I had in mind. We end up having to do something
completely different to support this more complex solution. I think we
might have referred to it as v2/v3 in a different thread, and
virt-bond in this thread.

Basically we need some sort of PCI or PCIe topology mapping for the
devices that can be translated into something we can communicate over
the communication channel. After that we also have the added
complexity of how do we figure out which Tx path we want to choose.
This is one of the reasons why I was thinking of something like a eBPF
blob that is handed up from the host side and into the guest to select
the Tx queue. That way when we add some new approach such as a
NUMA/cpu based netdev selection then we just provide an eBPF blob that
does that. Most of this is just theoretical at this point though since
I haven't had a chance to look into it too deeply yet. If you want to
take something like this on the help would always be welcome.. :)

The other thing I am looking at is trying to find a good way to do
dirty page tracking in the hypervisor using something like a
para-virtual IOMMU. However I don't have any ETA on that as I am just
starting out and have limited development time. If we get that in
place we can leave the VF in the guest until the very last moments
instead of having to remove it before we start the live migration.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

