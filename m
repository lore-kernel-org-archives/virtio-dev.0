Return-Path: virtio-dev-return-2733-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 938C85818F46
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Dec 2017 07:09:14 -0800 (PST)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Fri, 1 Dec 2017 15:09:08 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739376DA1@shsmsx102.ccr.corp.intel.com>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-6-git-send-email-wei.w.wang@intel.com>
	<201711301934.CDC21800.FSLtJFFOOVQHMO@I-love.SAKURA.ne.jp>
	<5A210C96.8050208@intel.com>
 <201712012202.BDE13557.MJFQLtOOHVOFSF@I-love.SAKURA.ne.jp>
In-Reply-To: <201712012202.BDE13557.MJFQLtOOHVOFSF@I-love.SAKURA.ne.jp>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v18 05/10] xbitmap: add more operations
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "willy@infradead.org" <willy@infradead.org>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Friday, December 1, 2017 9:02 PM, Tetsuo Handa wrote:
> Wei Wang wrote:
> > On 11/30/2017 06:34 PM, Tetsuo Handa wrote:
> > > Wei Wang wrote:
> > >> + * @start: the start of the bit range, inclusive
> > >> + * @end: the end of the bit range, inclusive
> > >> + *
> > >> + * This function is used to clear a bit in the xbitmap. If all the
> > >> +bits of the
> > >> + * bitmap are 0, the bitmap will be freed.
> > >> + */
> > >> +void xb_clear_bit_range(struct xb *xb, unsigned long start,
> > >> +unsigned long end) {
> > >> +	struct radix_tree_root *root =3D &xb->xbrt;
> > >> +	struct radix_tree_node *node;
> > >> +	void **slot;
> > >> +	struct ida_bitmap *bitmap;
> > >> +	unsigned int nbits;
> > >> +
> > >> +	for (; start < end; start =3D (start | (IDA_BITMAP_BITS - 1)) + 1)=
 {
> > >> +		unsigned long index =3D start / IDA_BITMAP_BITS;
> > >> +		unsigned long bit =3D start % IDA_BITMAP_BITS;
> > >> +
> > >> +		bitmap =3D __radix_tree_lookup(root, index, &node, &slot);
> > >> +		if (radix_tree_exception(bitmap)) {
> > >> +			unsigned long ebit =3D bit + 2;
> > >> +			unsigned long tmp =3D (unsigned long)bitmap;
> > >> +
> > >> +			nbits =3D min(end - start + 1, BITS_PER_LONG - ebit);
> > > "nbits =3D min(end - start + 1," seems to expect that start =3D=3D en=
d is
> > > legal for clearing only 1 bit. But this function is no-op if start =
=3D=3D end.
> > > Please clarify what "inclusive" intended.
> >
> > If xb_clear_bit_range(xb,10,10), then it is effectively the same as
> > xb_clear_bit(10). Why would it be illegal?
> >
> > "@start inclusive" means that the @start will also be included to be
> > cleared.
>=20
> If start =3D=3D end is legal,
>=20
>    for (; start < end; start =3D (start | (IDA_BITMAP_BITS - 1)) + 1) {
>=20
> makes this loop do nothing because 10 < 10 is false.


How about "start <=3D end "?

Best,
Wei




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

