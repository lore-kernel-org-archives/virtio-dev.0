Return-Path: <virtio-comment-return-3499-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221122151416-mutt-send-email-mst@kernel.org>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-3-mst@redhat.com> <878rk3fau0.fsf@redhat.com>
 <20221122151416-mutt-send-email-mst@kernel.org>
Date: Wed, 23 Nov 2022 10:26:25 +0100
Message-ID: <87pmdenhry.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v8 2/9] admin: introduce device group and related concepts
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 22 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Nov 22, 2022 at 01:11:19PM +0100, Cornelia Huck wrote:
>> On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > +\item[Member device]
>> > +        a device within a group. Owner device itself is not
>> 
>> s/Owner/The owner/
>> 
>> > +	a member of the group. In the future it is envisoned that
>> > +	new group types may be introduced where the owner
>> > +	device is a member of the group.
>> 
>> So, shouldn't it rather be: "Whether the owner device itself is a member
>> of the group depends on the type of the group." ?
>> Or do we want to
>> prefer the owner _not_ being a member of the group?
>
> Maybe I will drop this "In the future" thing. We'll cross that bridge
> when we get to it.

Ok, I think we can expand this later, if needed.

>
>> > +\item[Member identifier]
>> > +        each member has this identifier, unique within the group
>> > +	and used to address it through the owner device.
>> > +\item[Group type identifier]
>> > +	specifies what kind of member devices there are in a
>> > +	group, how is the member identifier interpreted
>> 
>> "how the member indentifier is interpreted, ..."
>> 
>> > +	and what kind of control does the owner have.
>> 
>> s/does the owner have/the owner has/
>> 
>> > +	At the moment, a given owner can control
>> > +	a single group of a given type, thus the type and
>> > +	the owner together identify the group.
>> > +	It is envisioned that this last restriction might be relaxed in the future,
>> > +	with multiple groups of the same type for a given owner.
>> 
>> Hm...
>> 
>> "A given owner may control a single group of a given type (which means
>> that the type and the owner together identify the group), or multiple
>> groups of the same type. Currently, only a single group per owner is
>> supported." ?
>> 
>> Basically, I'd prefer if we spelled out what is possible in general, and
>> then add a comment that only a subset of the possibilities is currently
>> implemented.
>
> I feel I went too broad here. Let's just drop the "It is envisioned"
> for now.

Ok, let's drop the "At the moment" prefix as well :)


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

