Return-Path: virtio-dev-return-4031-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 310D55819145
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 May 2018 08:47:40 -0700 (PDT)
Date: Wed, 2 May 2018 18:47:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180502184326-mutt-send-email-mst@kernel.org>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
 <1524848820-42258-4-git-send-email-sridhar.samudrala@intel.com>
 <20180428094205.GM5632@nanopsycho.orion>
 <638e52c7-64db-9d8d-7530-f6b000d3e292@intel.com>
 <20180430072034.GH23854@nanopsycho.orion>
 <9c6f055c-c665-0601-3973-bce74d72544b@intel.com>
 <20180502075021.GC19250@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180502075021.GC19250@nanopsycho>
Subject: [virtio-dev] Re: [PATCH net-next v9 3/4] virtio_net: Extend virtio to use VF
 datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 02, 2018 at 09:50:21AM +0200, Jiri Pirko wrote:
> Wed, May 02, 2018 at 02:20:26AM CEST, sridhar.samudrala@intel.com wrote:
> >On 4/30/2018 12:20 AM, Jiri Pirko wrote:
> >>=20
> >> > > Now I try to change mac of the failover master:
> >> > > [root@test1 ~]# ip link set ens3 addr 52:54:00:b2:a7:f3
> >> > > RTNETLINK answers: Operation not supported
> >> > >=20
> >> > > That I did expect to work. I would expect this would change the ma=
c of
> >> > > the master and both standby and primary slaves.
> >> > If a VF is untrusted, a VM will not able to change its MAC and moreo=
ver
> >> Note that at this point, I have no VF. So I'm not sure why you mention
> >> that.
> >>=20
> >>=20
> >> > in this mode we are assuming that the hypervisor has assigned the MA=
C and
> >> > guest is not expected to change the MAC.
> >> Wait, for ordinary old-fashioned virtio_net, as a VM user, I can change
> >> mac and all works fine. How is this different? Change mac on "failover
> >> instance" should work and should propagate the mac down to its slaves.
> >>=20
> >>=20
> >> > For the initial implementation, i would propose not allowing the gue=
st to
> >> > change the MAC of failover or standby dev.
> >> I see no reason for such restriction.
> >>=20
> >
> >It is true that a VM user can change mac address of a normal virtio-net =
interface,
> >however when it is in STANDBY mode i think we should not allow this chan=
ge specifically
> >because we are creating a failover instance based on a MAC that is assig=
ned by the
> >hypervisor.
> >
> >Moreover,=A0 in a cloud environment i would think that PF/hypervisor ass=
igns a MAC to
> >the VF and it cannot be changed by the guest.
>=20
> So that is easy. You allow the change of the mac and in the "failover"
> mac change implementation you propagate the change down to slaves. If
> one slave does not support the change, you bail out. And since VF does

I wish people would say primary/standby and not "VF" :)

> not allow it as you say, once it will be enslaved, the mac change could
> not be done. Seems like a correct behavior to me


what if primary does not allow mac changes and is attached after
mac is changed on standy?


> and is in-sync with how
> bond/team behaves.

I think in the end virtio can just block MAC changes for simplicity.

I personally don't see softmac as a must have feature in v1,
we can add it later.

What's the situation with init scripts and whether it's
possible to make them work well would be a better question.

>=20
> >
> >So for the initial implementation, do you see any issues with having thi=
s restriction
> >in STANDBY mode.
> >
> >

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

