Return-Path: virtio-dev-return-4124-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 422D15818E24
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 08:46:23 -0700 (PDT)
Date: Tue, 22 May 2018 18:46:21 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180522184112-mutt-send-email-mst@kernel.org>
References: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
 <1526954781-35359-3-git-send-email-sridhar.samudrala@intel.com>
 <20180522090637.GE2149@nanopsycho>
 <20180522090853.GF2149@nanopsycho>
 <39081bce-3913-5b07-3d07-0c476fca5e78@intel.com>
 <20180522153614.GK2149@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180522153614.GK2149@nanopsycho>
Subject: [virtio-dev] Re: Shepherd request (P83): Multipath TCP: Present Use Cases and an
 Upstream Future
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 22, 2018 at 05:36:14PM +0200, Jiri Pirko wrote:
> Tue, May 22, 2018 at 05:28:42PM CEST, sridhar.samudrala@intel.com wrote:
> >
> >On 5/22/2018 2:08 AM, Jiri Pirko wrote:
> >> Tue, May 22, 2018 at 11:06:37AM CEST, jiri@resnulli.us wrote:
> >> > Tue, May 22, 2018 at 04:06:18AM CEST, sridhar.samudrala@intel.com wr=
ote:
> >> > > Use the registration/notification framework supported by the gener=
ic
> >> > > failover infrastructure.
> >> > >=20
> >> > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >> > In previous patchset versions, the common code did
> >> > netdev_rx_handler_register() and netdev_upper_dev_link() etc
> >> > (netvsc_vf_join()). Now, this is still done in netvsc. Why?
> >> >=20
> >> > This should be part of the common "failover" code.
> >
> >Based on Stephen's feedback on earlier patches, i tried to minimize the =
changes to
> >netvsc and only commonize the notifier and the main event handler routin=
e.
> >Another complication is that netvsc does part of registration in a delay=
ed workqueue.
>=20
> :( This kind of degrades the whole efford of having single solution
> in "failover" module. I think that common parts, as
> netdev_rx_handler_register() and others certainly is should be inside
> the common module. This is not a good time to minimize changes. Let's do
> the thing properly and fix the netvsc mess now.
>=20
>=20
> >
> >It should be possible to move some of the code from net_failover.c to ge=
neric
> >failover.c in future if Stephen is ok with it.
> >
> >
> >> >=20
> >> Also note that in the current patchset you use IFF_FAILOVER flag for
> >> master, yet for the slave you use IFF_SLAVE. That is wrong.
> >> IFF_FAILOVER_SLAVE should be used.
> >
> >Not sure which code you are referring to.=A0 I only set IFF_FAILOVER_SLA=
VE
> >in patch 3.
>=20
> The existing netvsc driver.

We really can't change netvsc's flags now, even if it's interface is
messy, it's being used in the field. We can add a flag that makes netvsc
behave differently, and if this flag also allows enhanced functionality
userspace will gradually switch.

Anything breaking userspace I fully expect Stephen to nack and
IMO with good reason.

--=20
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

