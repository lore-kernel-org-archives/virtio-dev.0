Return-Path: virtio-comment-return-1293-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 26 May 2020 17:38:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20200526173835.4a839ec6.cohuck@redhat.com>
In-Reply-To: <733c9230-1bec-11f2-9fc9-ed53beedbc66@redhat.com>
References: <158994007522.397236.7536927155973222190.stgit@ahduyck-workstation>
	<158994014779.397236.836253101843237605.stgit@ahduyck-workstation>
	<60278259-9a04-77ab-f96f-c13bc2ffb070@redhat.com>
	<CAKgT0UfixL+bE9_-vLqvU02DMJ_9UDXR0c1C4M9U6wmH57H9Eg@mail.gmail.com>
	<53e66faa-ed7f-f7c1-6284-1e2a6e63c936@redhat.com>
	<CAKgT0Uc2haPLSaQg6Jsp-qtAZWgJ9Dku1RMqOhzYNg52SMkQug@mail.gmail.com>
	<733c9230-1bec-11f2-9fc9-ed53beedbc66@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v3 2/3] content: Document balloon
 feature page poison
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: David Hildenbrand <david@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 26 May 2020 17:28:00 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 26.05.20 16:50, Alexander Duyck wrote:
> > On Tue, May 26, 2020 at 1:24 AM David Hildenbrand <david@redhat.com> wrote:  

> >> Still wondering what to do with free page hinting ... in the meantime
> >> I'll have a look at free page reporting :)  
> > 
> > The problem is it is already out there so I worry we wouldn't ever be
> > able to get rid of it. At most we could deprecate it, but we are still
> > stuck with it consuming bit resources and such.  
> 
> Yeah, that's not an issue, they will simply turn to dead bits with
> minimal documentation. I just don't see us fixing/supporting that
> feature, really. Let's see what @MST things when he has time to look
> into this.
> 

If free page hinting is broken enough that we don't want anybody to try
implementing it, we maybe could:

- reserve the feature bit,
- say that the device SHOULD NOT offer it,
- say that the driver SHOULD NOT accept it?

Would avoid conflicts, and tell implementors that they should not
bother. (We can then proceed to start deprecating the Linux/QEMU
implementations.)


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

