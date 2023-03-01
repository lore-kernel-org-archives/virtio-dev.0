Return-Path: <virtio-dev-return-11348-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30488C6FA9D
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 17:29:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8EAAC6024B
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 17:29:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BD5F98667A
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 17:29:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5A38098666C; Wed,  1 Mar 2023 17:29:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 490CE98666D
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Mar 2023 17:29:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: AmWt6nP_Mm2y_Io2Gr2Kzw-1
Date: Wed, 1 Mar 2023 12:29:25 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xen.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sebastien Boeuf <sebastien.boeuf@intel.com>,
	Liu Jiang <gerry@linux.alibaba.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtio-dev@lists.oasis-open.org
Message-ID: <Y/+LdfF0rL3wEqfd@fedora>
References: <Y/9zkDAS4odz93GM@fedora>
 <877cw0ctpr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ji5TbNtGJsInl60F"
Content-Disposition: inline
In-Reply-To: <877cw0ctpr.fsf@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Subject: Re: [virtio-dev] [RFC QEMU] docs: vhost-user: Add custom memory
 mapping support

--ji5TbNtGJsInl60F
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2023 at 04:31:41PM +0000, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > [[PGP Signed Part:Undecided]]
> > Resend - for some reason my email didn't make it out.
> >
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Subject: Re: [virtio-dev] [RFC QEMU] docs: vhost-user: Add custom memory
> >  mapping support
> > To: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, "Michael S.
> >  Tsirkin" <mst@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org=
>,
> >  Alex Benn=E9e <alex.bennee@linaro.org>,
> > 	stratos-dev@op-lists.linaro.org, Oleksandr Tyshchenko
> >  <olekstysh@gmail.com>, xen-devel@lists.xen.org, Andrew Cooper
> >  <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>, Sebastien
> >  Boeuf
> > 	<sebastien.boeuf@intel.com>, Liu Jiang <gerry@linux.alibaba.com>, Math=
ieu
> >  Poirier <mathieu.poirier@linaro.org>
> > Date: Tue, 21 Feb 2023 10:17:01 -0500 (1 week, 1 day, 1 hour ago)
> > Flags: seen, signed, personal
> >
> > On Tue, Feb 21, 2023 at 03:20:41PM +0530, Viresh Kumar wrote:
> >> The current model of memory mapping at the back-end works fine with
> >> Qemu, where a standard call to mmap() for the respective file
> >> descriptor, passed from front-end, is generally all we need to do befo=
re
> >> the front-end can start accessing the guest memory.
> >>=20
> >> There are other complex cases though, where we need more information at
> >> the backend and need to do more than just an mmap() call. For example,
> >> Xen, a type-1 hypervisor, currently supports memory mapping via two
> >> different methods, foreign-mapping (via /dev/privcmd) and grant-dev (v=
ia
> >> /dev/gntdev). In both these cases, the back-end needs to call mmap()
> >> followed by an ioctl() (or vice-versa), and need to pass extra
> >> information via the ioctl(), like the Xen domain-id of the guest whose
> >> memory we are trying to map.
> >>=20
> >> Add a new protocol feature, 'VHOST_USER_PROTOCOL_F_CUSTOM_MMAP', which
> >> lets the back-end know about the additional memory mapping requirement=
s.
> >> When this feature is negotiated, the front-end can send the
> >> 'VHOST_USER_CUSTOM_MMAP' message type to provide the additional
> >> information to the back-end.
> >>=20
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> ---
> >>  docs/interop/vhost-user.rst | 32 ++++++++++++++++++++++++++++++++
> >>  1 file changed, 32 insertions(+)
> >
> > The alternative to an in-band approach is to configure these details
> > out-of-band. For example, via command-line options to the vhost-user
> > back-end:
> >
> >   $ my-xen-device --mapping-type=3Dforeign-mapping --domain-id=3D123
> >
> > I was thinking about both approaches and don't see an obvious reason to
> > choose one or the other. What do you think?
>=20
> In-band has the nice property of being dynamic and not having to have
> some other thing construct command lines. We are also trying to keep the
> daemons from being Xen specific and keep the type of mmap as an
> implementation detail that is mostly elided by the rust-vmm memory
> traits.

Okay.

> >
> >> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >> index 3f18ab424eb0..f2b1d705593a 100644
> >> --- a/docs/interop/vhost-user.rst
> >> +++ b/docs/interop/vhost-user.rst
> >> @@ -258,6 +258,23 @@ Inflight description
> >> =20
> >>  :queue size: a 16-bit size of virtqueues
> >> =20
> >> +Custom mmap description
> >> +^^^^^^^^^^^^^^^^^^^^^^^
> >> +
> >> ++-------+-------+
> >> +| flags | value |
> >> ++-------+-------+
> >> +
> >> +:flags: 64-bit bit field
> >> +
> >> +- Bit 0 is Xen foreign memory access flag - needs Xen foreign memory =
mapping.
> >> +- Bit 1 is Xen grant memory access flag - needs Xen grant memory mapp=
ing.
> >> +
> >> +:value: a 64-bit hypervisor specific value.
> >> +
> >> +- For Xen foreign or grant memory access, this is set with guest's xe=
n domain
> >> +  id.
> >
> > This is highly Xen-specific. How about naming the feature XEN_MMAP
> > instead of CUSTOM_MMAP? If someone needs to add other mmap data later,
> > they should define their own struct instead of trying to squeeze into
> > the same fields as Xen.
>=20
> We hope to support additional mmap mechanisms in the future - one
> proposal is to use the hypervisor specific interface to support an
> ioctl() that creates a domain specific device which can then be treated
> more generically.
>=20
> Could we not declare the message as flag + n bytes of domain specific
> message as defined my msglen?

What is the advantage over defining separate messages? Separate messages
are cleaner and more typesafe.

> > There is an assumption in this design that a single
> > VHOST_USER_CUSTOM_MMAP message provides the information necessary for
> > all mmaps. Are you sure the limitation that every mmap belongs to the
> > same domain will be workable in the future?
>=20
> Like a daemon servicing multiple VMs? Won't those still be separate
> vhost-user control channels though?

I don't have a concrete example, but was thinking of a guest that shares
memory with other guests (like the experimental virtio-vhost-user
device). Maybe there would be a scenario where some memory belongs to
one domain and some belongs to another (but has been mapped into the
first domain), and the vhost-user back-end needs to access both.

The other thing that comes to mind is that the spec must clearly state
which mmaps are affected by the Xen domain information. For example,
just mem table memory regions and not the
VHOST_USER_PROTOCOL_F_LOG_SHMFD feature?

> >
> >> +
> >>  C structure
> >>  -----------
> >> =20
> >> @@ -867,6 +884,7 @@ Protocol features
> >>    #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
> >>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
> >>    #define VHOST_USER_PROTOCOL_F_STATUS               16
> >> +  #define VHOST_USER_PROTOCOL_F_CUSTOM_MMAP          17
> >> =20
> >>  Front-end message types
> >>  -----------------------
> >> @@ -1422,6 +1440,20 @@ Front-end message types
> >>    query the back-end for its device status as defined in the Virtio
> >>    specification.
> >> =20
> >> +``VHOST_USER_CUSTOM_MMAP``
> >
> > Most vhost-user protocol messages have a verb like
> > get/set/close/add/listen/etc. I suggest renaming this to
> > VHOST_USER_SET_XEN_MMAP_INFO.
>=20
> VHOST_USER_CONFIG_MMAP_QUIRKS?
>=20
> VHOST_USER_CONFIG_MMAP_TYPE?

SET is the verb that's often used when the front-end provides
configuration parameters to the back-end (e.g.
VHOST_USER_SET_MEM_TABLE, VHOST_USER_SET_FEATURES, etc).

Stefan

--ji5TbNtGJsInl60F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmP/i3UACgkQnKSrs4Gr
c8g0qgf/aroAfmrv1TKO2MYdPTHh2fwqteXAzCt8TAYg0U3/xHgLY/ao9VPUDPKu
ZJkCQ/HBUSZnHbh8XkXwbq6D7vIyXBi6SYbQ59aLIPojafvrXUaKPgPD/4pr0Qut
bToML/9vzfGInhDDB2b6appsFUVpx2MIJf9mWDhsxeL9TeMcbiy+zefjizBejGAL
OM0aRjnxrG8pB4DIXlLM+K5gNm1hvuE/8SR0gEFQQ8KLmu4HpkTTCm1/hLvrfXRL
uCCAOg6CKfUfxJcxIywC4TgsJ6b3/7r8O3wwItcmvPCup8mc5dnz7c9W9JqkOU/i
MrmqUcDNOLz9nOqJfGufULCLFLawRA==
=OtkO
-----END PGP SIGNATURE-----

--ji5TbNtGJsInl60F--

