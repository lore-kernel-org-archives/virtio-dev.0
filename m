Return-Path: virtio-comment-return-1514-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 13 Nov 2020 02:24:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20201113022437-mutt-send-email-mst@kernel.org>
References: <160522183826.1914950.13732523926342676174.stgit@ahduyck-workstation>
MIME-Version: 1.0
In-Reply-To: <160522183826.1914950.13732523926342676174.stgit@ahduyck-workstation>
Subject: [virtio-comment] Re: [PATCH] content: Minor change to clarify free_page_hint_cmd_id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: david@redhat.com, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 12, 2020 at 02:57:50PM -0800, Alexander Duyck wrote:
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

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  content.tex |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 21e0cee903b0..9c39831acc15 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5206,8 +5206,8 @@ \subsection{Device configuration layout}\label{sec:Device Types / Memory Balloon
>    \field{num_pages} and \field{actual} are always available.
>  
>    \field{free_page_hint_cmd_id} is available if
> -    VIRTIO_BALLOON_F_FREE_PAGE_HINT has been negotiated and is read-only by
> -    the driver.
> +    VIRTIO_BALLOON_F_FREE_PAGE_HINT has been negotiated. The field is
> +    read-only by the driver.
>    \field{poison_val} is available if VIRTIO_BALLOON_F_PAGE_POISON has been
>      negotiated.
>  
> 


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

