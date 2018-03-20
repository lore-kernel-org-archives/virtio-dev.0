Return-Path: virtio-dev-return-3619-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4CE405818017
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Mar 2018 21:26:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Jonathan Helman <jonathan.helman@oracle.com>
In-Reply-To: <db6371af-f93d-4409-c910-2ff712196c5b@redhat.com>
Date: Mon, 19 Mar 2018 21:26:41 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <6ED6CAC9-FAD9-4A27-A9B1-C6EFC7627D68@oracle.com>
References: <1521497654-24807-1-git-send-email-jonathan.helman@oracle.com>
 <db6371af-f93d-4409-c910-2ff712196c5b@redhat.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio_balloon: export hugetlb page allocation counts
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


> On Mar 19, 2018, at 7:31 PM, Jason Wang <jasowang@redhat.com> wrote:
>=20
>=20
>=20
> On 2018=E5=B9=B403=E6=9C=8820=E6=97=A5 06:14, Jonathan Helman wrote:
>> Export the number of successful and failed hugetlb page
>> allocations via the virtio balloon driver. These 2 counts
>> come directly from the vm_events HTLB_BUDDY_PGALLOC and
>> HTLB_BUDDY_PGALLOC_FAIL.
>>=20
>> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
>=20
> Reviewed-by: Jason Wang <jasowang@redhat.com>

Thanks.

>=20
>> ---
>>  drivers/virtio/virtio_balloon.c     | 6 ++++++
>>  include/uapi/linux/virtio_balloon.h | 4 +++-
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/virtio/virtio_balloon.c =
b/drivers/virtio/virtio_balloon.c
>> index dfe5684..6b237e3 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -272,6 +272,12 @@ static unsigned int update_balloon_stats(struct =
virtio_balloon *vb)
>>  				pages_to_bytes(events[PSWPOUT]));
>>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, =
events[PGMAJFAULT]);
>>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, =
events[PGFAULT]);
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
>> +		    events[HTLB_BUDDY_PGALLOC]);
>> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGFAIL,
>> +		    events[HTLB_BUDDY_PGALLOC_FAIL]);
>> +#endif
>>  #endif
>>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
>>  				pages_to_bytes(i.freeram));
>> diff --git a/include/uapi/linux/virtio_balloon.h =
b/include/uapi/linux/virtio_balloon.h
>> index 4e8b830..40297a3 100644
>> --- a/include/uapi/linux/virtio_balloon.h
>> +++ b/include/uapi/linux/virtio_balloon.h
>> @@ -53,7 +53,9 @@ struct virtio_balloon_config {
>>  #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
>>  #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in =
/proc */
>>  #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
>> -#define VIRTIO_BALLOON_S_NR       8
>> +#define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page =
allocations */
>> +#define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation =
failures */
>> +#define VIRTIO_BALLOON_S_NR       10
>>    /*
>>   * Memory statistics structure.
>=20
> Not for this patch, but it looks to me that exporting such nr through =
uapi is fragile.

Sorry, can you explain what you mean here?

Jon

>=20
> Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

