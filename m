Return-Path: virtio-dev-return-5100-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72347985DF2
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Nov 2018 21:23:56 +0000 (UTC)
Date: Fri, 30 Nov 2018 16:23:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181130162140-mutt-send-email-mst@kernel.org>
References: <20181129181659.21284-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129181659.21284-1-stefanha@redhat.com>
Subject: [virtio-dev] Re: [PATCH v10] vsock: add vsock device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Ian Campbell <ian.campbell@docker.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 29, 2018 at 06:16:59PM +0000, Stefan Hajnoczi wrote:
> +\subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> +
> +\begin{description}
> +There are currently no feature bits defined for this device.
> +\end{description}

this breaks latex: \item must be used within description.
I have dropped description environment.
Pls make sure to build document before posting.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

