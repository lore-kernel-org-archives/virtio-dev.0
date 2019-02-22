Return-Path: virtio-dev-return-5490-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 491F69860E5
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Feb 2019 01:14:01 +0000 (UTC)
MIME-Version: 1.0
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
 <1523386790-12396-5-git-send-email-sridhar.samudrala@intel.com>
 <20180410142608.50f15b45@xeon-e3> <20180411075334.GK2028@nanopsycho>
In-Reply-To: <20180411075334.GK2028@nanopsycho>
From: Siwei Liu <loseweigh@gmail.com>
Date: Thu, 21 Feb 2019 17:14:44 -0800
Message-ID: <CADGSJ214RJV_zWVBGv0Ydo=CJj6WESTYAH=PpaYLFHdtWVrm3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] net_failover slave udev renaming (was Re: [RFC PATCH net-next v6 4/4]
 netvsc: refactor notifier/event handling code to use the bypass framework)
To: Jiri Pirko <jiri@resnulli.us>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Sridhar Samudrala <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev <virtio-dev@lists.oasis-open.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, liran.alon@oracle.com, si-wei liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Sorry for replying to this ancient thread. There was some remaining
issue that I don't think the initial net_failover patch got addressed
cleanly, see:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1815268

The renaming of 'eth0' to 'ens4' fails because the udev userspace was
not specifically writtten for such kernel automatic enslavement.
Specifically, if it is a bond or team, the slave would typically get
renamed *before* virtual device gets created, that's what udev can
control (without getting netdev opened early by the other part of
kernel) and other userspace components for e.g. initramfs,
init-scripts can coordinate well in between. The in-kernel
auto-enslavement of net_failover breaks this userspace convention,
which don't provides a solution if user care about consistent naming
on the slave netdevs specifically.

Previously this issue had been specifically called out when IFF_HIDDEN
and the 1-netdev was proposed, but no one gives out a solution to this
problem ever since. Please share your mind how to proceed and solve
this userspace issue if netdev does not welcome a 1-netdev model.

On Wed, Apr 11, 2018 at 12:53 AM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Tue, Apr 10, 2018 at 11:26:08PM CEST, stephen@networkplumber.org wrote:
> >On Tue, 10 Apr 2018 11:59:50 -0700
> >Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> >
> >> Use the registration/notification framework supported by the generic
> >> bypass infrastructure.
> >>
> >> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >> ---
> >
> >Thanks for doing this.  Your current version has couple show stopper
> >issues.
> >
> >First, the slave device is instantly taking over the slave.
> >This doesn't allow udev/systemd to do its device rename of the slave
> >device. Netvsc uses a delayed work to workaround this.
>
> Wait. Why the fact a device is enslaved has to affect the udev in any
> way? If it does, smells like a bug in udev.

See above for clarifications.

Thanks,


>
>
> >
> >Secondly, the select queue needs to call queue selection in VF.
> >The bonding/teaming logic doesn't work well for UDP flows.
> >Commit b3bf5666a510 ("hv_netvsc: defer queue selection to VF")
> >fixed this performance problem.
> >
> >Lastly, more indirection is bad in current climate.
> >
> >I am not completely adverse to this but it needs to be fast, simple
> >and completely transparent.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

