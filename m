Return-Path: virtio-dev-return-3374-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 742035818F23
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Mar 2018 09:06:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <af96a5d1-021e-7b2c-b18d-db80c44f3067@intel.com>
References: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
 <1519934923-39372-3-git-send-email-sridhar.samudrala@intel.com>
 <20180302083605.GD2099@nanopsycho> <CAKgT0UeMQ8GkHLrCHQ_OfFw3beqHVM2QvbRt7zoZKf1Vwvbt1A@mail.gmail.com>
 <20180302162017.GG2099@nanopsycho> <af96a5d1-021e-7b2c-b18d-db80c44f3067@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 2 Mar 2018 09:06:37 -0800
Message-ID: <CAKgT0UfpBR0q5q46fWZC8zFRxTzVqCZ=EDq3MNOi3uoSWsPCAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when available
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Mar 2, 2018 at 8:37 AM, Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
>
>
> On 3/2/2018 8:20 AM, Jiri Pirko wrote:
>
> Fri, Mar 02, 2018 at 04:26:25PM CET, alexander.duyck@gmail.com wrote:
>
> On Fri, Mar 2, 2018 at 12:36 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>
> Thu, Mar 01, 2018 at 09:08:43PM CET, sridhar.samudrala@intel.com wrote:
>
> This patch enables virtio_net to switch over to a VF datapath when a VF
> netdev is present with the same MAC address. It allows live migration
> of a VM with a direct attached VF without the need to setup a bond/team
> between a VF and virtio net device in the guest.
>
> The hypervisor needs to enable only one datapath at any time so that
> packets don't get looped back to the VM over the other datapath. When a VF
> is plugged, the virtio datapath link state can be marked as down. The
> hypervisor needs to unplug the VF device from the guest on the source host
> and reset the MAC filter of the VF to initiate failover of datapath to
> virtio before starting the migration. After the migration is completed,
> the destination hypervisor sets the MAC filter on the VF and plugs it back
> to the guest to switch over to VF datapath.
>
> When BACKUP feature is enabled, an additional netdev(bypass netdev) is
> created that acts as a master device and tracks the state of the 2 lower
> netdevs. The original virtio_net netdev is marked as 'backup' netdev and a
> passthru device with the same MAC is registered as 'active' netdev.
>
> This patch is based on the discussion initiated by Jesse on this thread.
> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> drivers/net/virtio_net.c | 683
> ++++++++++++++++++++++++++++++++++++++++++++++-
>
> As I wrote to the discussion of the other version of this patchset,
> I strongly believe you need to have a common part in net/core/ that will
> be shared by both virtio_net and netvsc. There there should be explicit
> limits for this in-driver bonding solution, like max 1 vf slave, etc.
>
> Yeah, this code essentially calls out the "shareable" code with a
> comment at the start and end of the section what defines the
> virtio_bypass functionality. It would just be a matter of mostly
> cutting and pasting to put it into a separate driver module.
>
> Please put it there and unite the use of it with netvsc.
>
> Based on Stephen's responses, it is not clear if netvsc would be OK to move
> to
> the 3 netdev solution at this time. When another paravirtual driver would
> like
> to use this solution, we can do refactoring at that time.
>
> The design limits things to a 1:1 relationship since we just have the
> child and backup pointers, but I don't think I am seeing exception
> handling to prevent us from overwriting the child pointers so there
> may be a leak there.
>
>
> We only allow one active netdev registered as a child. There is a check to
> make sure that if an active netdev is registered, another one with same MAC
> is not allowed. I don't think there is a leak.
>
> vbi = netdev_priv(dev);
>         backup = (child_netdev->dev.parent == dev->dev.parent);
>         if (backup ? rtnl_dereference(vbi->backup_netdev) :
>                         rtnl_dereference(vbi->active_netdev)) {
>                 netdev_info(dev,
>                             "%s attempting to join bypass dev when %s
> already present\n",
>                             child_netdev->name, backup ? "backup" :
> "active");
>                 return NOTIFY_DONE;
>         }
>
>         /* Avoid non pci devices as active netdev */
>         if (!backup && (!child_netdev->dev.parent ||
>                         !dev_is_pci(child_netdev->dev.parent)))
>                 return NOTIFY_DONE;
>
> Thanks
> Sridhar

I overlooked that part.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

