Return-Path: <virtio-dev-return-11632-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B45C61DA4
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:23:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2E6C842B67
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:23:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1AC25986406
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:23:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 07ADF9863FC; Wed, 15 Mar 2023 15:23:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5692986402
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Mar 2023 15:23:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: em-7fTesP0K7Dia1OiuQ0g-1
Date: Wed, 15 Mar 2023 11:23:46 -0400
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
Message-ID: <20230315152346.GB16636@fedora>
References: <cover.1678351495.git.viresh.kumar@linaro.org>
 <6d0bd7f0e1aeec3ddb603ae4ff334c75c7d0d7b3.1678351495.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P0+YC7C2o+OYytsg"
Content-Disposition: inline
In-Reply-To: <6d0bd7f0e1aeec3ddb603ae4ff334c75c7d0d7b3.1678351495.git.viresh.kumar@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Subject: [virtio-dev] Re: [PATCH V3 2/2] docs: vhost-user: Add Xen specific memory mapping
 support

--P0+YC7C2o+OYytsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 02:21:01PM +0530, Viresh Kumar wrote:
> The current model of memory mapping at the back-end works fine where a
> standard call to mmap() (for the respective file descriptor) is enough
> before the front-end can start accessing the guest memory.
>=20
> There are other complex cases though where the back-end needs more
> information and simple mmap() isn't enough. For example Xen, a type-1
> hypervisor, currently supports memory mapping via two different methods,
> foreign-mapping (via /dev/privcmd) and grant-dev (via /dev/gntdev). In
> both these cases, the back-end needs to call mmap() and ioctl(), with
> extra information like the Xen domain-id of the guest whose memory we
> are trying to map.
>=20
> Add a new protocol feature, 'VHOST_USER_PROTOCOL_F_XEN_MMAP', which lets
> the back-end know about the additional memory mapping requirements.
> When this feature is negotiated, the front-end will send the additional
> information within the memory regions themselves.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  docs/interop/vhost-user.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--P0+YC7C2o+OYytsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQR4wIACgkQnKSrs4Gr
c8ijJQf/ROItbOzK05kO+CNPMWwO1kNa7SCAoOi6cgj452PZmF2b9cMDlBDfbsL6
jliMKUFGBKkpKxBUD8JcxGlRwcJQT8AwG0KFjCWLwkzNx7BxnrDaXf0I2UgR5E/6
nwHD2R+3K4Ay9QCyIUVrOWmId37SHX2e04d+1+iy7lWdQ1FM5/wc43Bt8aq80oYK
YSuDIuFRXxJdr2Uxr8J9tKgukl3AkoKP8wzFUilzBN9GIMe9wPet8WF7sPwCi5+s
QiQ9CVojLmqiXSDYUrAa2/Y8SypGimyvuy1C3kbNl7i2ow9r7vMr9Vw+/X0uhXb9
Klhmo2NzmGmYT3bQ8RzENH0DYPwCNQ==
=4b2c
-----END PGP SIGNATURE-----

--P0+YC7C2o+OYytsg--

