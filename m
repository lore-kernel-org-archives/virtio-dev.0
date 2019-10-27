Return-Path: virtio-dev-return-6257-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23B5D983E7E
	for <virtio-dev@lists.oasis-open.org>; Sun, 27 Oct 2019 11:37:51 +0000 (UTC)
Date: Sun, 27 Oct 2019 07:37:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191027073636-mutt-send-email-mst@kernel.org>
References: <19cb1e74-66ac-3658-ff01-1414b5039158@siemens.com>
MIME-Version: 1.0
In-Reply-To: <19cb1e74-66ac-3658-ff01-1414b5039158@siemens.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [virtio-dev] virtio-spec: Clarify /wrt maintaining a split-queue
 descriptors
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Oct 12, 2019 at 09:20:02AM +0200, Jan Kiszka wrote:
> Hi all,
>=20
> I'm wondering if the spec is clear enough regarding who is in charge of
> setting fields in a descriptor of split virtqueues. Background: I just
> made the mistake in an experimental backend of writing back the number
> of bytes pushed into a buffer not only in virtq_used_elem but also the
> referenced virtq_desc - with unpleasant effects for the guest.
>=20
> The spec in section 2.6.8 reads to me like virtq_used_elem.len is rather
> informative. At least this section leaves it fuzzy to me whether there
> are other sources from where a driver can find out how much a device has
> delivered - and misled me to also update virtq_desc.len in the device.
>=20
> But maybe I'm missing a clear note in another section.
>=20
> Jan


Well it does say this:

=09When the driver wants to send a buffer to the device, it fills in
=09a slot in the descriptor table (or chains several together), and
=09writes the descriptor index into the available ring.  It then
=09notifies the device. When the device has finished a buffer, it
=09writes the descriptor index into the used ring, and sends a
=09used buffer notification.

but for sure, documenting that descriptor area is read-only by device
can't hurt.

> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

