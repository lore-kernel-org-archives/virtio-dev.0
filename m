Return-Path: virtio-dev-return-3539-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id BC7605818F87
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Mar 2018 17:44:27 -0700 (PDT)
Date: Wed, 14 Mar 2018 02:44:23 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180314024228-mutt-send-email-mst@kernel.org>
References: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
 <1519934923-39372-3-git-send-email-sridhar.samudrala@intel.com>
 <CADGSJ23unj7P_d_vpitAp9JZ7F76i-Y8msaHU4_pOV_4-UUinw@mail.gmail.com>
 <eac018bf-58fe-188d-0dad-f454c9affebb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <eac018bf-58fe-188d-0dad-f454c9affebb@intel.com>
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when
 available
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Siwei Liu <loseweigh@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 13, 2018 at 05:28:07PM -0700, Samudrala, Sridhar wrote:
> > I am not sure if it's a good idea to leave the
> > virtio_bypass around if running into failure: the guest is not
> > migratable as the VF doesn't have a backup path,
>=20
> Are you talking about a failure when registering backup netdev?=A0 This s=
hould not
> happen, but i guess we can improve error handling in such scenario.

A nice way to do this would be to clear the backup feature bit.

>=20
> > And perhaps the worse
> > part is that, it now has two interfaces with identical MAC address but
> > one of them is invalid (user cannot use the virtio interface as it has
> > a dampened datapath). IMHO the virtio_bypass and its lower netdev
> > should be destroyed at all when it fails to bind the VF, and
> > technically, there should be some way to propogate the failure status
> > to the hypervisor/backend, indicating that the VM is not migratable
> > because of guest software errors (maybe by clearing out the backup
> > feature from the guest virtio driver so host can see/learn it).
>=20
> In BACKUP mode, user can only use the upper virtio_bypass netdev and that=
 will
> always be there. Any failure to enslave VF netdev is not fatal, but i wil=
l see
> if we can improve the error handling of failure to enslave backup netdev.
> Also, i don't think the BACKUP feature bit is negotiable with the host.
>=20
> Thanks
> Sridhar

All bits are negotiable.  It's up to the host whether to support
a device with this bit clear, or to fail negotiation.

--=20
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

