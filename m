Return-Path: virtio-dev-return-7568-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 923D1986079
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jul 2020 07:32:53 +0000 (UTC)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
From: teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20200716023910-mutt-send-email-mst@kernel.org>
Date: Thu, 16 Jul 2020 15:32:30 +0800
Message-Id: <4F64B592-03CF-46F5-B761-78B4EBA5028E@linux.alibaba.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
 <1594867315-8626-6-git-send-email-teawater@gmail.com>
 <20200716023910-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [RFC for qemu v4 2/2] virtio_balloon: Add dcvq to
 deflate continuous pages
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>, david@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



> 2020=E5=B9=B47=E6=9C=8816=E6=97=A5 14:39=EF=BC=8CMichael S. Tsirkin <mst@=
redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Jul 16, 2020 at 10:41:55AM +0800, Hui Zhu wrote:
>> This commit adds a vq dcvq to deflate continuous pages.
>> When VIRTIO_BALLOON_F_CONT_PAGES is set, try to get continuous pages
>> from icvq and use madvise MADV_WILLNEED with the pages.
>>=20
>> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>=20
> This is arguably something to benchmark. Does guest benefit
> from MADV_WILLNEED or loose performance?

MADV_WILLNEED will call madvise_willneed in the host kernel.
madvise_willneed will schedule all required I/O operations (swap in or vfs_=
fadvise POSIX_FADV_WILLNEED) of the address.

But the pages of the balloon are released by MADV_DONTNEED.
So I think MADV_WILLNEED will not affect the performance of the guest in th=
e most of situations.

Best,
Hui

>=20
>> ---
>> hw/virtio/virtio-balloon.c         | 14 +++++++++-----
>> include/hw/virtio/virtio-balloon.h |  2 +-
>> 2 files changed, 10 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index d36a5c8..165adf7 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -138,7 +138,8 @@ static void balloon_inflate_page(VirtIOBalloon *ball=
oon,
>> }
>>=20
>> static void balloon_deflate_page(VirtIOBalloon *balloon,
>> -                                 MemoryRegion *mr, hwaddr mr_offset)
>> +                                 MemoryRegion *mr, hwaddr mr_offset,
>> +                                 size_t size)
>> {
>>     void *addr =3D memory_region_get_ram_ptr(mr) + mr_offset;
>>     ram_addr_t rb_offset;
>> @@ -153,10 +154,11 @@ static void balloon_deflate_page(VirtIOBalloon *ba=
lloon,
>>     rb_page_size =3D qemu_ram_pagesize(rb);
>>=20
>>     host_addr =3D (void *)((uintptr_t)addr & ~(rb_page_size - 1));
>> +    size &=3D ~(rb_page_size - 1);
>>=20
>>     /* When a page is deflated, we hint the whole host page it lives
>>      * on, since we can't do anything smaller */
>> -    ret =3D qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED);
>> +    ret =3D qemu_madvise(host_addr, size, QEMU_MADV_WILLNEED);
>>     if (ret !=3D 0) {
>>         warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
>>                     strerror(errno));
>> @@ -354,7 +356,7 @@ static void virtio_balloon_handle_output(VirtIODevic=
e *vdev, VirtQueue *vq)
>>             pa =3D (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
>>             offset +=3D 4;
>>=20
>> -            if (vq =3D=3D s->icvq) {
>> +            if (vq =3D=3D s->icvq || vq =3D=3D s->dcvq) {
>>                 uint32_t psize_ptr;
>>                 if (iov_to_buf(elem->out_sg, elem->out_num, offset, &psi=
ze_ptr, 4) !=3D 4) {
>>                     break;
>> @@ -383,8 +385,9 @@ static void virtio_balloon_handle_output(VirtIODevic=
e *vdev, VirtQueue *vq)
>>                     balloon_inflate_page(s, section.mr,
>>                                          section.offset_within_region,
>>                                          psize, &pbp);
>> -                } else if (vq =3D=3D s->dvq) {
>> -                    balloon_deflate_page(s, section.mr, section.offset_=
within_region);
>> +                } else if (vq =3D=3D s->dvq || vq =3D=3D s->dcvq) {
>> +                    balloon_deflate_page(s, section.mr, section.offset_=
within_region,
>> +                                         psize);
>>                 } else {
>>                     g_assert_not_reached();
>>                 }
>> @@ -838,6 +841,7 @@ static void virtio_balloon_device_realize(DeviceStat=
e *dev, Error **errp)
>>=20
>>     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_CONT_PAGES=
)) {
>>         s->icvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_ou=
tput);
>> +        s->dcvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_o=
utput);
>>     }
>>=20
>>     reset_stats(s);
>> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virt=
io-balloon.h
>> index 6a2514d..848a7fb 100644
>> --- a/include/hw/virtio/virtio-balloon.h
>> +++ b/include/hw/virtio/virtio-balloon.h
>> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
>>=20
>> typedef struct VirtIOBalloon {
>>     VirtIODevice parent_obj;
>> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq;
>> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *icvq, *dcvq;
>>     uint32_t free_page_report_status;
>>     uint32_t num_pages;
>>     uint32_t actual;
>> --=20
>> 2.7.4
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

