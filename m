Return-Path: <virtio-dev-return-11483-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A64BC6FD1A
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 16:27:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 913C42B01F
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 16:27:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 736C19866D1
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 16:27:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5ADEF9866C6; Tue,  7 Mar 2023 16:27:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 475699866C7
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Mar 2023 16:27:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 8JjfyWGJMh-pzHJNb1HhRw-1
Date: Tue, 7 Mar 2023 11:22:37 -0500
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
Message-ID: <20230307162237.GI124259@fedora>
References: <7c3c120bcf2cf023e873800fd3f55239dd302e38.1678100850.git.viresh.kumar@linaro.org>
 <20230306153451.GB51288@fedora>
 <20230307054336.uvky5d7q2qqlxdcv@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nbguWgicIIaPt9yw"
Content-Disposition: inline
In-Reply-To: <20230307054336.uvky5d7q2qqlxdcv@vireshk-i7>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Subject: [virtio-dev] Re: [PATCH V2] docs: vhost-user: Add Xen specific memory mapping
 support

--nbguWgicIIaPt9yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 11:13:36AM +0530, Viresh Kumar wrote:
> On 06-03-23, 10:34, Stefan Hajnoczi wrote:
> > On Mon, Mar 06, 2023 at 04:40:24PM +0530, Viresh Kumar wrote:
> > > +Xen mmap description
> > > +^^^^^^^^^^^^^^^^^^^^
> > > +
> > > ++-------+-------+
> > > +| flags | domid |
> > > ++-------+-------+
> > > +
> > > +:flags: 64-bit bit field
> > > +
> > > +- Bit 0 is set for Xen foreign memory memory mapping.
> > > +- Bit 1 is set for Xen grant memory memory mapping.
> > > +- Bit 2 is set if the back-end can directly map additional memory (l=
ike
> > > +  descriptor buffers or indirect descriptors, which aren't part of a=
lready
> > > +  shared memory regions) without the need of front-end sending an ad=
ditional
> > > +  memory region first.
> >=20
> > I don't understand what Bit 2 does. Can you rephrase this? It's unclear
> > to me how additional memory can be mapped without a memory region
> > (especially the fd) is sent?
>=20
> I (somehow) assumed we will be able to use the same file descriptor
> that was shared for the virtqueues memory regions and yes I can see
> now why it wouldn't work or create problems.
>=20
> And I need suggestion now on how to make this work.
>=20
> With Xen grants, the front end receives grant address from the from
> guest kernel, they aren't physical addresses, kind of IOMMU stuff.
>=20
> The back-end gets access for memory regions of the virtqueues alone
> initially.  When the back-end gets a request, it reads the descriptor
> and finds the buffer address, which isn't part of already shared
> regions. The same happens for descriptor addresses in case indirect
> descriptor feature is negotiated.
>=20
> At this point I was thinking maybe the back-end can simply call the
> mmap/ioctl to map the memory, using the file descriptor used for the
> virtqueues.
>=20
> How else can we make this work ? We also need to unmap/remove the
> memory region, as soon as the buffer is processed as the grant address
> won't be relevant for any subsequent request.
>=20
> Should I use VHOST_USER_IOTLB_MSG for this ? I did look at it and I
> wasn't convinced if it was an exact fit. For example it says that a
> memory address reported with miss/access fail should be part of an
> already sent memory region, which isn't the case here.

VHOST_USER_IOTLB_MSG probably isn't necessary because address
translation is not required. It will also reduce performance by adding
extra communication.

Instead, you could change the 1 memory region : 1 mmap relationship that
existing non-Xen vhost-user back-end implementations have. In Xen
vhost-user back-ends, the memory region details (including the file
descriptor and Xen domain id) would be stashed away in back-end when the
front-end adds memory regions. No mmap would be performed upon
VHOST_USER_ADD_MEM_REG or VHOST_USER_SET_MEM_TABLE.

Whenever the back-end needs to do DMA, it looks up the memory region and
performs the mmap + Xen-specific calls:
- A long-lived mmap of the vring is set up when
  VHOST_USER_SET_VRING_ENABLE is received.
- Short-lived mmaps of the indirect descriptors and memory pointed to by
  the descriptors is set up by the virtqueue processing code.

Does this sound workable to you?

Stefan

--nbguWgicIIaPt9yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQHZM0ACgkQnKSrs4Gr
c8i5EggAg1GeEPUvp+GwY0QihzVnKf+r+lRnlqHwuK0q1FLR6JJV1fNRijZ8krVW
5V3DfLnwR1mMa79qp725qrhLPIi3gwvmF9cflASoGNAAS5IEv9BWiPHB5jPpNNM+
iryUkktHZmXccCvA4VHH2arBKu0NInpWPHYx3xiR3AcX4XO71acWnJ09z7JouNdO
238p6zVatv8npgLHqJEvinlIgvqZ6NHCAyC/JJAhQ3fS/u9+yKVfbFMWHGpiNLsl
2Y/qoHZRyz8aeJfzNP5kQqCSp8Io2SGnsp5Q2GAP6xgHAtLVdWhk8EAgyYdgagWj
t5VNNWpSF7qOKix2kqlSdoYYgJ/myQ==
=4zqx
-----END PGP SIGNATURE-----

--nbguWgicIIaPt9yw--

