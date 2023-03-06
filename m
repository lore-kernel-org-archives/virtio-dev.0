Return-Path: <virtio-dev-return-11447-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE12C678D4
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 15:35:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D3A9E70227
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 15:35:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B17F49866C2
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 15:35:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9A0D69866B8; Mon,  6 Mar 2023 15:35:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 741E99866B9
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Mar 2023 15:35:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: L6-SOzn1OAGkVQ6bHCSKTQ-1
Date: Mon, 6 Mar 2023 10:34:51 -0500
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
Message-ID: <20230306153451.GB51288@fedora>
References: <7c3c120bcf2cf023e873800fd3f55239dd302e38.1678100850.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6o3hguOYtNtqX5if"
Content-Disposition: inline
In-Reply-To: <7c3c120bcf2cf023e873800fd3f55239dd302e38.1678100850.git.viresh.kumar@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Subject: [virtio-dev] Re: [PATCH V2] docs: vhost-user: Add Xen specific memory mapping
 support

--6o3hguOYtNtqX5if
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 04:40:24PM +0530, Viresh Kumar wrote:
> The current model of memory mapping at the back-end works fine where a
> standard call to mmap() (for the respective file descriptor) is enough
> before the front-end can start accessing the guest memory.
>=20
> There are other complex cases though where the back-end needs more
> information and simple mmap() isn't enough. For example Xen, a type-1
> hypervisor, currently supports memory mapping via two different methods,
> foreign-mapping (via /dev/privcmd) and grant-dev (via /dev/gntdev). In
> both these cases, the back-end needs to call mmap() and ioctl(), and
> need to pass extra information via the ioctl(), like the Xen domain-id
> of the guest whose memory we are trying to map.
>=20
> Add a new protocol feature, 'VHOST_USER_PROTOCOL_F_XEN_MMAP', which lets
> the back-end know about the additional memory mapping requirements.
> When this feature is negotiated, the front-end can send the
> 'VHOST_USER_SET_XEN_MMAP' message type to provide the additional
> information to the back-end.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - Make the custom mmap feature Xen specific, instead of being generic.
> - Clearly define which memory regions are impacted by this change.
> - Allow VHOST_USER_SET_XEN_MMAP to be called multiple times.
> - Additional Bit(2) property in flags.
>=20
>  docs/interop/vhost-user.rst | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 3f18ab424eb0..8be5f5eae941 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -258,6 +258,24 @@ Inflight description
> =20
>  :queue size: a 16-bit size of virtqueues
> =20
> +Xen mmap description
> +^^^^^^^^^^^^^^^^^^^^
> +
> ++-------+-------+
> +| flags | domid |
> ++-------+-------+
> +
> +:flags: 64-bit bit field
> +
> +- Bit 0 is set for Xen foreign memory memory mapping.
> +- Bit 1 is set for Xen grant memory memory mapping.
> +- Bit 2 is set if the back-end can directly map additional memory (like
> +  descriptor buffers or indirect descriptors, which aren't part of alrea=
dy
> +  shared memory regions) without the need of front-end sending an additi=
onal
> +  memory region first.

I don't understand what Bit 2 does. Can you rephrase this? It's unclear
to me how additional memory can be mapped without a memory region
(especially the fd) is sent?

> +
> +:domid: a 64-bit Xen hypervisor specific domain id.
> +
>  C structure
>  -----------
> =20
> @@ -867,6 +885,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>    #define VHOST_USER_PROTOCOL_F_STATUS               16
> +  #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> =20
>  Front-end message types
>  -----------------------
> @@ -1422,6 +1441,23 @@ Front-end message types
>    query the back-end for its device status as defined in the Virtio
>    specification.
> =20
> +``VHOST_USER_SET_XEN_MMAP``
> +  :id: 41
> +  :equivalent ioctl: N/A
> +  :request payload: Xen mmap description
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_XEN_MMAP`` protocol feature has been
> +  successfully negotiated, this message is submitted by the front-end to=
 set the
> +  Xen hypervisor specific memory mapping configurations at the back-end.=
  These
> +  configurations should be used to mmap memory regions, virtqueues, desc=
riptors
> +  and descriptor buffers. The front-end must send this message before any
> +  memory-regions are sent to the back-end via ``VHOST_USER_SET_MEM_TABLE=
`` or
> +  ``VHOST_USER_ADD_MEM_REG`` message types. The front-end can send this =
message
> +  multiple times, if different mmap configurations are required for diff=
erent
> +  memory regions, where the most recent ``VHOST_USER_SET_XEN_MMAP`` must=
 be used
> +  by the back-end to map any newly shared memory regions.

This message modifies the behavior of subsequent
VHOST_USER_SET_MEM_TABLE and VHOST_USER_ADD_MEM_REG messages. The memory
region structs can be extended and then VHOST_USER_SET_XEN_MMAP isn't
needed.

In other words:

  When VHOST_USER_PROTOCOL_F_XEN_MMAP is negotiated, each "Memory
  regions description" and "Single memory region description" has the
  following additional fields appended:

  +----------------+-------+
  | xen_mmap_flags | domid |
  +----------------+-------+

  :xen_mmap_flags: 64-bit bit field
  :domid: a 64-bit Xen hypervisor specific domain id.

Stefan

--6o3hguOYtNtqX5if
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQGCBsACgkQnKSrs4Gr
c8ioqggAr0sNzP6odV6D7q20EAu0U8ebHThXN5TfZ1O1jznw1m3Elh711LqjSR95
EMzBureA2VwAyjXwVMLcA557T71x1e7yaFBaw0EIn1sbQaX0yjUlWZq0RiR4JKbw
JL84hDrdkgZtX+Vixgp+rfRBs8qyzSBmC8F0zlhJOgkEob0D42hsNPohZIKj2g3a
cmUEXIrrGswJ5gYyP/j0OT587jybv4MA08r/jssdjYniqvZk7Ud3gcnen2pzTLyk
B6c/fjZK7a6nqf3LQSssQ5xbQR4mbQ9UTdkzh1jyT7v3B/3dWnnBviWftlvMjSDR
PZ4DkjIcicxpP2QEr9tK1qBSqf2K8g==
=pUBT
-----END PGP SIGNATURE-----

--6o3hguOYtNtqX5if--

