Return-Path: virtio-comment-return-1303-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <158994007522.397236.7536927155973222190.stgit@ahduyck-workstation>
 <158994014779.397236.836253101843237605.stgit@ahduyck-workstation>
 <60278259-9a04-77ab-f96f-c13bc2ffb070@redhat.com>
 <CAKgT0UfixL+bE9_-vLqvU02DMJ_9UDXR0c1C4M9U6wmH57H9Eg@mail.gmail.com>
 <53e66faa-ed7f-f7c1-6284-1e2a6e63c936@redhat.com>
 <CAKgT0Uc2haPLSaQg6Jsp-qtAZWgJ9Dku1RMqOhzYNg52SMkQug@mail.gmail.com>
 <733c9230-1bec-11f2-9fc9-ed53beedbc66@redhat.com>
 <20200526173835.4a839ec6.cohuck@redhat.com> <5ECE053E.1000206@intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8e33db19-cd4f-6c3d-feff-ecd4437cfcba@redhat.com>
Date: Wed, 27 May 2020 14:08:30 +0200
MIME-Version: 1.0
In-Reply-To: <5ECE053E.1000206@intel.com>
Content-Language: en-US
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH v3 2/3] content:
 Document balloon feature page poison
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
To: Wei Wang <wei.w.wang@intel.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 27.05.20 08:14, Wei Wang wrote:
> On 05/26/2020 11:38 PM, Cornelia Huck wrote:
>> On Tue, 26 May 2020 17:28:00 +0200 David Hildenbrand
>> <david@redhat.com> wrote:
>>=20
>>> On 26.05.20 16:50, Alexander Duyck wrote:
>>>> On Tue, May 26, 2020 at 1:24 AM David Hildenbrand
>>>> <david@redhat.com> wrote:
>>>>> Still wondering what to do with free page hinting ... in the
>>>>> meantime I'll have a look at free page reporting :)
>>>> The problem is it is already out there so I worry we wouldn't
>>>> ever be able to get rid of it. At most we could deprecate it,
>>>> but we are still stuck with it consuming bit resources and
>>>> such.
>>> Yeah, that's not an issue, they will simply turn to dead bits
>>> with minimal documentation. I just don't see us fixing/supporting
>>> that feature, really. Let's see what @MST things when he has time
>>> to look into this.
>>>=20
>> If free page hinting is broken enough that we don't want anybody to
>> try implementing it, we maybe could:
>=20
> May I know the issues that you got with FREE_PAGE_HINT?

Did you follow the discussion on the spec updates proposed by Alexander?
We might have identified a couple of issues in the QEMU side trying to
document the semantics of free page hinting.

For example:

1. When migration fails in the live stage, before stopping the VM, the
guest will not receive a VIRTIO_BALLOON_CMD_ID_DONE.

2. The semantics about what could happen to hinted pages are unclear
(and it is unclear if the current QEMU behavior is a BUG or expected).
While writing to a hinted page will result in the page to get migrated
and not change the value, the guest might suddenly observe a change in
the value when only reading the page.

Imagine (just as an example) something in a guest like

/* page was previously hinted and is now getting reused by the guest */
if (!page_filled_with(page, X)) {
=09fill_page_with(page, X);
}
/* migration finished, value of page changed */

And Alexander pointed out, that the change the guest might observe might
not be the change to a zero page. Semantics unclear.

There seems to be more related to the async iothread/reset handling
+ the other fixes I just recently sent.


It would be good if you could have a look at the matter.

--=20
Thanks,

David / dhildenb


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

