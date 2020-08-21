Return-Path: virtio-comment-return-1419-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <159777170579.321346.6847340295291298122.stgit@ahduyck-workstation>
 <159777195453.321346.1306200388566612957.stgit@ahduyck-workstation>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7a5391d4-fba0-698a-b332-42482de07bc6@redhat.com>
Date: Fri, 21 Aug 2020 20:23:01 +0200
MIME-Version: 1.0
In-Reply-To: <159777195453.321346.1306200388566612957.stgit@ahduyck-workstation>
Content-Language: en-US
Subject: Re: [virtio-comment] [PATCH RESEND v6 1/3] content: Document balloon
 feature free page hints
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>, mst@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 18.08.20 19:32, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Free page hints allow the balloon driver to provide information on what
> pages are not currently in use so that we can avoid the cost of copying
> them in migration scenarios. Add a feature description for free page hints
> describing basic functioning and requirements.
> 
> In working on this the specification as pointed out certain issues with the
> Linux driver and QEMU device implementation. The issues include:
> 1. The Linux driver does not re-initialize pages when it reuses them
> before receiving the "DONE" command, as such this can lead to possible data
> corruption.
> 2. The QEMU device is not returning the "DONE" command if a migration
> fails. This results in the guest holding onto pages until forced out by the
> shrinker.
> 
> There are also additional issues that have been found not related to the
> specification.
> 
> There is currently discussion on if the feature should be removed so this
> patch is a place-holder for if we decide to keep the feature and fix the
> issues. Otherwise this patch can be dropped and we can work on a patch to
> document the need to avoid the feature.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

