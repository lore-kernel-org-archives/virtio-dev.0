Return-Path: <virtio-comment-return-2542-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220114082838-mutt-send-email-mst@kernel.org>
References: <20220114082838-mutt-send-email-mst@kernel.org>
Date: Fri, 14 Jan 2022 17:33:58 +0100
Message-ID: <87y23iuvih.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio-dev] spec inconsistency: Device Configuration Interrupt
 bit in ISR status
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 14 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> It is unfortunate that it does not copy this requirement in more places,
> and that the non-conformance text is incomplete and does not
> mention the MSI-X usage at all.
>
> I propose to extend 4.1.4.5 ISR status capability and 
> 4.1.5.4 Notification of Device Configuration Changes
> to mention the MSI use.

I agree that it would make sense to be more explicit, especially if
people have already fallen into this trap.

My main question is: do we still have time to do this for 1.2? By the
proposed timeline, we need to have a vote open by Jan 17th (next
Monday), which is cutting it awfully close.

[We seem to have quite some last minute stuff, sigh.]


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

