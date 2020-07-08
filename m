Return-Path: virtio-comment-return-1342-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 8 Jul 2020 13:17:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20200708131727.1475371a.cohuck@redhat.com>
In-Reply-To: <159407030893.314508.17503485189063768225.stgit@ahduyck-workstation>
References: <159407016215.314508.9176034874281717628.stgit@ahduyck-workstation>
	<159407030893.314508.17503485189063768225.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v5 2/3] content: Document balloon feature free page
 reporting
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: mst@redhat.com, david@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 06 Jul 2020 14:18:28 -0700
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Free page reporting is a feature that allows the guest to proactively
> report unused pages to the host. By making use of this feature is is
> possible to reduce the overall memory footprint of the guest in cases where
> some significant portion of the memory is idle. Add documentation for the
> free page reporting feature describing the functionality and requirements.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  conformance.tex |    2 +
>  content.tex     |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 87 insertions(+), 4 deletions(-)

(...)

> @@ -5088,10 +5097,16 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
>  \item If the VIRTIO_BALLOON_F_PAGE_POISON feature bit is negotiated, the
>    driver updates the \field{poison_val} configuration field.
>  
> +\item If the VIRTIO_BALLOON_F_PAGE_REPORTING feature bit is negotiated the

s/negotiated/negotiated,/

> +  reporting_vq is identified.

Again, maybe use "identify the reporting_vq", just to keep the wording
more consistent?

> +
>  \item DRIVER_OK is set: device operation begins.
>  
>  \item If the VIRTIO_BALLOON_F_STATS_VQ feature bit is negotiated, then
>    notify the device about the stats virtqueue buffer.
> +
> +\item If the VIRTIO_BALLOON_F_PAGE_REPORTING feature bit is negotiated then

s/negotiated/negotiated,/

> +  begin reporting free pages to the device.
>  \end{enumerate}
>  
>  \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}

(...)

Other than those nits, looks good to me.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


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

