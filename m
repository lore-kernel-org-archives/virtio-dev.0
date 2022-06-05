Return-Path: <virtio-dev-return-9587-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7BAD98630B
	for <virtio-dev@lists.oasis-open.org>; Sun,  5 Jun 2022 20:29:23 +0000 (UTC)
Date: Sun, 5 Jun 2022 16:29:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220605162839-mutt-send-email-mst@kernel.org>
References: <6355541D-E117-4E7F-B5D9-3CD0028ED7FF@apple.com>
MIME-Version: 1.0
In-Reply-To: <6355541D-E117-4E7F-B5D9-3CD0028ED7FF@apple.com>
Subject: Re: [virtio-dev] Clarification of VIRTIO_F_EVENT_IDX driver
 conditions.
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Patrick Mosca <pmosca@apple.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cameron Esfahani <dirty@apple.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jun 01, 2022 at 01:03:27PM -0700, Patrick Mosca wrote:
> We ran into an edge case in the VIRTIO_F_EVENT_IDX feature where a notification could be missed if there is a "streak" in skipped notifications. If the difference between the event index and available index wraps before a notification is needed, there exists a case where a notification must be sent but is not sent.
> 
> 
> Signed-off-by: Patrick Mosca <pmosca@apple.com>
> Signed-off-by: Cameron Esfahani <dirty@apple.com>
> ---
>  split-ring.tex | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/split-ring.tex b/split-ring.tex
> index bfef62d..9650e5e 100644
> --- a/split-ring.tex
> +++ b/split-ring.tex
> @@ -530,6 +530,9 @@ \subsection{Available Buffer Notification Suppression}\label{sec:Basic Facilitie
>          \item If the \field{idx} field in the available ring (which determined
>            where that descriptor index was placed) was equal to
>            \field{avail_event}, the driver MUST send a notification.
> +        \item If the number of descriptors added to the queue since
> +          the last notification is greater than 65535, the driver MUST
> +          send a notification.
>          \item Otherwise the driver SHOULD NOT send a notification.
>    \end{itemize}
>  \end{itemize}
> -- 
> 2.32.0 (Apple Git-131)
> 
> 
> -Patrick Mosca

I am not sure I understand. Can you give an example of how the issue
triggers please?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

