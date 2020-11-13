Return-Path: virtio-comment-return-1515-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 13 Nov 2020 11:16:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20201113111657.6da91cda.cohuck@redhat.com>
In-Reply-To: <160522183826.1914950.13732523926342676174.stgit@ahduyck-workstation>
References: <160522183826.1914950.13732523926342676174.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH] content: Minor change to clarify free_page_hint_cmd_id
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: mst@redhat.com, david@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 12 Nov 2020 14:57:50 -0800
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> The original wording was a bit unclear and could have been misinterpreted
> as indicating that VIRTIO_BALLOON_FREE_PAGE_HINT was read-only instead of
> the field free_page_hint_cmd_id. To clarify that break it up into two
> sentences making it clear that the field is only available if the feature
> is negotiated, and that the field is read-only.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  content.tex |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, pushed under the minor cleanups rule.


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

