Return-Path: <virtio-dev-return-11631-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDEEC6FD1D
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:20:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 725ED3E30C
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:20:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B9B0986414
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:20:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2DACB9863FC; Wed, 15 Mar 2023 15:20:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 92A4C986402
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Mar 2023 15:19:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Y1iB8-ULMEmIOBRp7xXAWQ-1
Date: Wed, 15 Mar 2023 11:19:26 -0400
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
Message-ID: <20230315151926.GA16636@fedora>
References: <cover.1678351495.git.viresh.kumar@linaro.org>
 <7c3718e5eb99178b22696682ae73aca6df1899c7.1678351495.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O6Z1j1jWA1rh9Wk0"
Content-Disposition: inline
In-Reply-To: <7c3718e5eb99178b22696682ae73aca6df1899c7.1678351495.git.viresh.kumar@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Subject: [virtio-dev] Re: [PATCH V3 1/2] docs: vhost-user: Define memory region separately

--O6Z1j1jWA1rh9Wk0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 02:21:00PM +0530, Viresh Kumar wrote:
> The same layout is defined twice, once in "single memory region
> description" and then in "memory regions description".
>=20
> Separate out details of memory region from these two and reuse the same
> definition later on.
>=20
> While at it, also rename "memory regions description" to "multiple
> memory regions description", to avoid potential confusion around similar
> names. And define single region before multiple ones.
>=20
> This is just a documentation optimization, the protocol remains the same.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  docs/interop/vhost-user.rst | 39 +++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O6Z1j1jWA1rh9Wk0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQR4f4ACgkQnKSrs4Gr
c8hxuAgAp4tv1RvL4VEQf8h2eNofdFyh5KtzUUn3Q8+eRtHJ3diMD9MshFHl+4JC
5M+4rQoODTICf0bgn659wYs5D2fF0cSYSAsqJx0594lLJknX0LX+YvRGWycVz/8l
81+iNJPaGsPU5k32TGorK5F3ZoxrnzgH6f8BPnVkACmABhyOZcVd+ZLHZZdatiLr
4En+5Ngv9Fd7eq66UO3JilZJZTTai0zWGU+enR8CmTGoD8olqx9gJvUOJjpEPkcK
3Muq52sLH3DaiK1/KUaz9g6j0TYlHwu+65YGRXE4vNM4Po8bY8GeRZRrnBZFcLmA
OPu6eaIIlskeujoEmUZ0StMCy0BT4w==
=GWpD
-----END PGP SIGNATURE-----

--O6Z1j1jWA1rh9Wk0--

