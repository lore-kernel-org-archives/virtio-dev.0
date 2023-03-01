Return-Path: <virtio-dev-return-11345-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBACC6FA9D
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 15:47:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 325982A8E8
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 15:47:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B8E6986672
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 15:47:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 04E6D986669; Wed,  1 Mar 2023 15:47:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E632B98666B
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Mar 2023 15:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 189UUaEtMpOJYaipxaj5jQ-1
Date: Wed, 1 Mar 2023 10:47:28 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xen.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sebastien Boeuf <sebastien.boeuf@intel.com>,
	Liu Jiang <gerry@linux.alibaba.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Message-ID: <Y/9zkDAS4odz93GM@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="REA+6g3fXhuAA0Hw"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Subject: Re: [virtio-dev] [RFC QEMU] docs: vhost-user: Add custom memory
 mapping support

--REA+6g3fXhuAA0Hw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Resend - for some reason my email didn't make it out.

----- Forwarded message from Stefan Hajnoczi <stefanha@redhat.com> -----

Date: Tue, 21 Feb 2023 10:17:01 -0500
=46rom: Stefan Hajnoczi <stefanha@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsi=
rkin" <mst@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Alex =
Benn=E9e <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org, Oleksandr Tyshchenko <olekstysh@gmail.com=
>, xen-devel@lists.xen.org, Andrew Cooper <andrew.cooper3@citrix.com>, Juer=
gen Gross <jgross@suse.com>, Sebastien Boeuf
	<sebastien.boeuf@intel.com>, Liu Jiang <gerry@linux.alibaba.com>, Mathieu =
Poirier <mathieu.poirier@linaro.org>
Subject: Re: [virtio-dev] [RFC QEMU] docs: vhost-user: Add custom memory ma=
pping support
Message-ID: <Y/TgbZLY894p4a1S@fedora>

On Tue, Feb 21, 2023 at 03:20:41PM +0530, Viresh Kumar wrote:
> The current model of memory mapping at the back-end works fine with
> Qemu, where a standard call to mmap() for the respective file
> descriptor, passed from front-end, is generally all we need to do before
> the front-end can start accessing the guest memory.
>=20
> There are other complex cases though, where we need more information at
> the backend and need to do more than just an mmap() call. For example,
> Xen, a type-1 hypervisor, currently supports memory mapping via two
> different methods, foreign-mapping (via /dev/privcmd) and grant-dev (via
> /dev/gntdev). In both these cases, the back-end needs to call mmap()
> followed by an ioctl() (or vice-versa), and need to pass extra
> information via the ioctl(), like the Xen domain-id of the guest whose
> memory we are trying to map.
>=20
> Add a new protocol feature, 'VHOST_USER_PROTOCOL_F_CUSTOM_MMAP', which
> lets the back-end know about the additional memory mapping requirements.
> When this feature is negotiated, the front-end can send the
> 'VHOST_USER_CUSTOM_MMAP' message type to provide the additional
> information to the back-end.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  docs/interop/vhost-user.rst | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

The alternative to an in-band approach is to configure these details
out-of-band. For example, via command-line options to the vhost-user
back-end:

  $ my-xen-device --mapping-type=3Dforeign-mapping --domain-id=3D123

I was thinking about both approaches and don't see an obvious reason to
choose one or the other. What do you think?

> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 3f18ab424eb0..f2b1d705593a 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -258,6 +258,23 @@ Inflight description
> =20
>  :queue size: a 16-bit size of virtqueues
> =20
> +Custom mmap description
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-------+-------+
> +| flags | value |
> ++-------+-------+
> +
> +:flags: 64-bit bit field
> +
> +- Bit 0 is Xen foreign memory access flag - needs Xen foreign memory map=
ping.
> +- Bit 1 is Xen grant memory access flag - needs Xen grant memory mapping.
> +
> +:value: a 64-bit hypervisor specific value.
> +
> +- For Xen foreign or grant memory access, this is set with guest's xen d=
omain
> +  id.

This is highly Xen-specific. How about naming the feature XEN_MMAP
instead of CUSTOM_MMAP? If someone needs to add other mmap data later,
they should define their own struct instead of trying to squeeze into
the same fields as Xen.

There is an assumption in this design that a single
VHOST_USER_CUSTOM_MMAP message provides the information necessary for
all mmaps. Are you sure the limitation that every mmap belongs to the
same domain will be workable in the future?

> +
>  C structure
>  -----------
> =20
> @@ -867,6 +884,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>    #define VHOST_USER_PROTOCOL_F_STATUS               16
> +  #define VHOST_USER_PROTOCOL_F_CUSTOM_MMAP          17
> =20
>  Front-end message types
>  -----------------------
> @@ -1422,6 +1440,20 @@ Front-end message types
>    query the back-end for its device status as defined in the Virtio
>    specification.
> =20
> +``VHOST_USER_CUSTOM_MMAP``

Most vhost-user protocol messages have a verb like
get/set/close/add/listen/etc. I suggest renaming this to
VHOST_USER_SET_XEN_MMAP_INFO.

> +  :id: 41
> +  :equivalent ioctl: N/A
> +  :request payload: Custom mmap description
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_CUSTOM_MMAP`` protocol feature has be=
en
> +  successfully negotiated, this message is submitted by the front-end to
> +  notify the back-end of the special memory mapping requirements, that t=
he
> +  back-end needs to take care of, while mapping any memory regions sent
> +  over by the front-end. The front-end must send this message before
> +  any memory-regions are sent to the back-end via ``VHOST_USER_SET_MEM_T=
ABLE``
> +  or ``VHOST_USER_ADD_MEM_REG`` message types.
> +
> =20
>  Back-end message types
>  ----------------------
> --=20
> 2.31.1.272.g89b43f80a514
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20



----- End forwarded message -----

--REA+6g3fXhuAA0Hw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmP/c5AACgkQnKSrs4Gr
c8j7xQgAvP7ofHadadItgG48Mx2Y5ZxqGbcYrkWl9Z3LFplSdvSL57D89nu+U3I6
YHEQTjc/aXyZHAQJfeQbTMfjAcLzsaLD5dGpmypZN6nwMwMdjkNDIVMgJiac2hau
cqRAcrZcmGYvODag1LKvbofZvYcHspHO/IGF6BMbpFV98d9gpVJFS5NaE+I67Em7
6abQUP4VmzhyO9vqAYxtCjTo+Wt5mCOjHXCBbHFrCS1SeknZDReUQcoE9fmZZjOq
5wxk221ccSUwRM+bRvugkEKi0jzpc9TFJt7sR+hcgHPatPBi/KeLjojHBrRInnfx
CDcx43fMekxlUmcVrsH0AYySsoS0wg==
=zYpW
-----END PGP SIGNATURE-----

--REA+6g3fXhuAA0Hw--

