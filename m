Return-Path: virtio-comment-return-1421-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <159777170579.321346.6847340295291298122.stgit@ahduyck-workstation>
 <159777196680.321346.538006583207267488.stgit@ahduyck-workstation>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fb54b19e-4036-676b-dda9-668e75c9c296@redhat.com>
Date: Fri, 21 Aug 2020 20:26:35 +0200
MIME-Version: 1.0
In-Reply-To: <159777196680.321346.538006583207267488.stgit@ahduyck-workstation>
Content-Language: en-US
Subject: Re: [virtio-comment] [PATCH RESEND v6 3/3] content: Document balloon
 feature free page reporting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>, mst@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 18.08.20 19:32, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Free page reporting is a feature that allows the guest to proactively
> report unused pages to the host. By making use of this feature is is
> possible to reduce the overall memory footprint of the guest in cases where
> some significant portion of the memory is idle. Add documentation for the
> free page reporting feature describing the functionality and requirements.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!


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

