Return-Path: virtio-dev-return-7296-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 890A2985EC5
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 May 2020 18:13:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Date: Fri, 8 May 2020 20:13:21 +0200
Message-Id: <DB82EE9A-39EF-414B-9BB7-C5B283F014A4@redhat.com>
References: <CAKgT0UcygsdURGivgTb08i2Ot0TQAzahLKhkkzXvhsoEU-7p3Q@mail.gmail.com>
In-Reply-To: <CAKgT0UcygsdURGivgTb08i2Ot0TQAzahLKhkkzXvhsoEU-7p3Q@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v23 QEMU 0/5] virtio-balloon: add support for page poison reporting and free page reporting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>



> Am 08.05.2020 um 19:31 schrieb Alexander Duyck <alexander.duyck@gmail.com=
>:
>=20
> =EF=BB=BFI just wanted to follow up since it has been a little over a wee=
k
> since I submitted this and I haven't heard anything back. It looks
> like the linux-headers patches can be dropped since the headers appear
> to have been synced. I was wondering if I should resubmit with just
> the 3 patches that are adding the functionality, or if this patch-set
> is good as-is?

Should be good as-is. However, if the new compat machines are already upstr=
eam, you might want to tackle that right away.

Cheers and have a nice weekend!

>=20
> Thanks.
>=20
> - Alex
>=20
>> On Mon, Apr 27, 2020 at 5:53 PM Alexander Duyck
>> <alexander.duyck@gmail.com> wrote:
>>=20
>> This series provides an asynchronous means of reporting free guest pages
>> to QEMU through virtio-balloon so that the memory associated with those
>> pages can be dropped and reused by other processes and/or guests on the
>> host. Using this it is possible to avoid unnecessary I/O to disk and
>> greatly improve performance in the case of memory overcommit on the host=
.
>>=20
>> I originally submitted this patch series back on February 11th 2020[1],
>> but at that time I was focused primarily on the kernel portion of this
>> patch set. However as of April 7th those patches are now included in
>> Linus's kernel tree[2] and so I am submitting the QEMU pieces for
>> inclusion.
>>=20
>> [1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@local=
host.localdomain/
>> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Db0c504f154718904ae49349147e3b7e6ae91ffdc
>>=20
>> Changes from v17:
>> Fixed typo in patch 1 title
>> Addressed white-space issues reported via checkpatch
>> Added braces {} for two if statements to match expected coding style
>>=20
>> Changes from v18:
>> Updated patches 2 and 3 based on input from dhildenb
>> Added comment to patch 2 describing what keeps us from reporting a bad p=
age
>> Added patch to address issue with ROM devices being directly writable
>>=20
>> Changes from v19:
>> Added std-headers change to match changes pushed for linux kernel header=
s
>> Added patch to remove "report" from page hinting code paths
>> Updated comment to better explain why we disable hints w/ page poisoning
>> Removed code that was modifying config size for poison vs hinting
>> Dropped x-page-poison property
>> Added code to bounds check the reported region vs the RAM block
>> Dropped patch for ROM devices as that was already pulled in by Paolo
>>=20
>> Changes from v20:
>> Rearranged patches to push Linux header sync patches to front
>> Removed association between free page hinting and VIRTIO_BALLOON_F_PAGE_=
POISON
>> Added code to enable VIRTIO_BALLOON_F_PAGE_POISON if page reporting is e=
nabled
>> Fixed possible resource leak if poison or qemu_balloon_is_inhibited retu=
rn true
>>=20
>> Changes from v21:
>> Added ack for patch 3
>> Rewrote patch description for page poison reporting feature
>> Made page-poison independent property and set to enabled by default
>> Added logic to migrate poison_val
>> Added several comments in code to better explain features
>> Switched free-page-reporting property to disabled by default
>>=20
>> Changes from v22:
>> Added ack for patches 4 & 5
>> Added additional comment fixes in patch 3 to remove "reporting" referenc=
e
>> Renamed rvq in patch 5 to reporting_vq to improve readability
>> Moved call adding reporting_vq to after free_page_vq to fix VQ ordering
>>=20
>> ---
>>=20
>> Alexander Duyck (5):
>>      linux-headers: Update to allow renaming of free_page_report_cmd_id
>>      linux-headers: update to contain virito-balloon free page reporting
>>      virtio-balloon: Replace free page hinting references to 'report' wi=
th 'hint'
>>      virtio-balloon: Implement support for page poison reporting feature
>>      virtio-balloon: Provide an interface for free page reporting
>>=20
>>=20
>> hw/virtio/virtio-balloon.c                      |  176 +++++++++++++++++=
+-----
>> include/hw/virtio/virtio-balloon.h              |   23 ++-
>> include/standard-headers/linux/virtio_balloon.h |   12 +-
>> 3 files changed, 159 insertions(+), 52 deletions(-)
>>=20
>> --
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

