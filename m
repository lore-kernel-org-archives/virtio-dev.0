Return-Path: <virtio-comment-return-4254-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230215061424-mutt-send-email-mst@kernel.org>
References: <20230203183532.90685-1-parav@nvidia.com>
 <87k00p9331.fsf@redhat.com>
 <20230215061424-mutt-send-email-mst@kernel.org>
Date: Wed, 15 Feb 2023 13:19:25 +0100
Message-ID: <871qmrdstu.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH] content.tex Fix Driver notifications label
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 15 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Feb 10, 2023 at 12:23:14PM +0100, Cornelia Huck wrote:
>> On Fri, Feb 03 2023, Parav Pandit <parav@nvidia.com> wrote:
>> 
>> > Driver notifications section is under "Basic Facilities of a Virtio
>> > Device". However, the label is placed under "Virtqueues" section.
>> >
>> > Fix the label references.
>> >
>> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>> > ---
>> >  content.tex | 14 +++++++-------
>> >  1 file changed, 7 insertions(+), 7 deletions(-)
>> 
>> Not sure if it was originally intended to sit unter the virtqueues
>> section (it was lifted up one level as it disappeared under the packet
>> ring section), might have been.
>> 
>> It probably makes sense to not try and move it back into the virtqueues
>> section, and instead do your change. Other opinions?
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> Minor fix does not need a vote.
> Cornelia are you applying this?

Pushed.


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

