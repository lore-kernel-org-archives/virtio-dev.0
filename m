Return-Path: virtio-dev-return-5943-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2ABDF985BC0
	for <virtio-dev@lists.oasis-open.org>; Mon, 12 Aug 2019 15:26:56 +0000 (UTC)
References: <20190812131235.27244-1-nitesh@redhat.com>
 <20190812131357.27312-1-nitesh@redhat.com>
 <20190812131357.27312-2-nitesh@redhat.com>
 <CAKgT0Uc8kGwX8VwU2b51qVuh2z5eZQ6XhSnYMryTVa_pKHCvew@mail.gmail.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <101649ae-58d4-76ee-91f3-42ac1c145c46@redhat.com>
Date: Mon, 12 Aug 2019 11:26:38 -0400
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uc8kGwX8VwU2b51qVuh2z5eZQ6XhSnYMryTVa_pKHCvew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [QEMU Patch 2/2] virtio-balloon: support for handling page
 reporting
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com, Yang Zhang <yang.zhang.wz@gmail.com>, Rik van Riel <riel@surriel.com>, David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, john.starks@microsoft.com, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/12/19 11:18 AM, Alexander Duyck wrote:
> On Mon, Aug 12, 2019 at 6:14 AM Nitesh Narayan Lal <nitesh@redhat.com> =
wrote:
>> Page reporting is a feature which enables the virtual machine to repor=
t
>> chunk of free pages to the hypervisor.
>> This patch enables QEMU to process these reports from the VM and disca=
rd the
>> unused memory range.
>>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>> ---
>>  hw/virtio/virtio-balloon.c         | 41 +++++++++++++++++++++++++++++=
+
>>  include/hw/virtio/virtio-balloon.h |  2 +-
>>  2 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index 25de154307..1132e47ee0 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>> @@ -320,6 +320,39 @@ static void balloon_stats_set_poll_interval(Objec=
t *obj, Visitor *v,
>>      balloon_stats_change_timer(s, 0);
>>  }
>>
>> +static void virtio_balloon_handle_reporting(VirtIODevice *vdev, VirtQ=
ueue *vq)
>> +{
>> +    VirtQueueElement *elem;
>> +
>> +    while ((elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
>> +        unsigned int i;
>> +
>> +        for (i =3D 0; i < elem->in_num; i++) {
>> +            void *gaddr =3D elem->in_sg[i].iov_base;
>> +            size_t size =3D elem->in_sg[i].iov_len;
>> +            ram_addr_t ram_offset;
>> +            size_t rb_page_size;
>> +           RAMBlock *rb;
>> +
>> +            if (qemu_balloon_is_inhibited())
>> +                continue;
>> +
>> +            rb =3D qemu_ram_block_from_host(gaddr, false, &ram_offset=
);
>> +            rb_page_size =3D qemu_ram_pagesize(rb);
>> +
>> +            /* For now we will simply ignore unaligned memory regions=
 */
>> +            if ((ram_offset | size) & (rb_page_size - 1))
>> +                continue;
>> +
>> +            ram_block_discard_range(rb, ram_offset, size);
>> +        }
>> +
>> +        virtqueue_push(vq, elem, 0);
>> +        virtio_notify(vdev, vq);
>> +        g_free(elem);
>> +    }
>> +}
>> +
> No offense, but I am a bit annoyed.

None taken at all.

>  If you are going to copy my code
> you should at least keep up with the fixes.


Yeah I did refer to your code and just because the quality of your code i=
s
better than what I posted earlier and there is quite a lot for me to lear=
n from it.


> stuff to handle the poison value. If you are going to just duplicate
> my setup you might as well have just pulled the QEMU patches from the
> last submission I did. Then this would have at least has the fix for
> the page poisoning.
>

The only reason I didn't include the poison change as I still need to und=
erstand
them.
I have this mentioned in my cover-email.


>  Also it wouldn't hurt to mention that you are
> basing it off of the patch set I submitted since it hasn't been
> accepted yet.


My bad!! This I will surely do from next time.

>
>>  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueu=
e *vq)
>>  {
>>      VirtIOBalloon *s =3D VIRTIO_BALLOON(vdev);
>> @@ -792,6 +825,12 @@ static void virtio_balloon_device_realize(DeviceS=
tate *dev, Error **errp)
>>      s->dvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_outp=
ut);
>>      s->svq =3D virtio_add_queue(vdev, 128, virtio_balloon_receive_sta=
ts);
>>
>> +    if (virtio_has_feature(s->host_features,
>> +                           VIRTIO_BALLOON_F_REPORTING)) {
>> +        s->reporting_vq =3D virtio_add_queue(vdev, 16,
>> +                                          virtio_balloon_handle_repor=
ting);
>> +    }
>> +
>>      if (virtio_has_feature(s->host_features,
>>                             VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>          s->free_page_vq =3D virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE=
,
>> @@ -912,6 +951,8 @@ static Property virtio_balloon_properties[] =3D {
>>       * is disabled, resulting in QEMU 3.1 migration incompatibility. =
 This
>>       * property retains this quirk for QEMU 4.1 machine types.
>>       */
>> +    DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_featur=
es,
>> +                    VIRTIO_BALLOON_F_REPORTING, true),
>>      DEFINE_PROP_BOOL("qemu-4-0-config-size", VirtIOBalloon,
>>                       qemu_4_0_config_size, false),
>>      DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHRE=
AD,
>> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/vi=
rtio-balloon.h
>> index d1c968d237..15a05e6435 100644
>> --- a/include/hw/virtio/virtio-balloon.h
>> +++ b/include/hw/virtio/virtio-balloon.h
>> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_report_status {
>>
>>  typedef struct VirtIOBalloon {
>>      VirtIODevice parent_obj;
>> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
>> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq;
>>      uint32_t free_page_report_status;
>>      uint32_t num_pages;
>>      uint32_t actual;
>> --
>> 2.21.0
>> q
--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

