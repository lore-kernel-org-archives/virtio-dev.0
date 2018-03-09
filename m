Return-Path: virtio-dev-return-3507-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 437285818F95
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Mar 2018 14:53:50 -0800 (PST)
Date: Sat, 10 Mar 2018 00:53:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180310005226-mutt-send-email-mst@kernel.org>
References: <7849539ddc252748908b3ff62ca6539b6dea73b0.1519303843.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7849539ddc252748908b3ff62ca6539b6dea73b0.1519303843.git.tgolembi@redhat.com>
Subject: [virtio-dev] Re: [PATCH v2] content: document balloon memory statistics
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, Jonathan Helman <jonathan.helman@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 22, 2018 at 01:50:52PM +0100, Tomáš Golembiovský wrote:
> Linux kernel provides some balloon memory statistics that were not
> included in the specs. Include them to avoid any ID clashes in the
> future.
> 
> Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>

No comments on this so far. When you feel it's ready to vote,
please open a github issue:
https://github.com/oasis-tcs/virtio-spec/issues
Set it as ready to vote and I'll start voting.

> ---
>  content.tex | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index c7ef7fd..7e9e026 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5028,6 +5028,8 @@ struct virtio_balloon_stat {
>  #define VIRTIO_BALLOON_S_MINFLT   3
>  #define VIRTIO_BALLOON_S_MEMFREE  4
>  #define VIRTIO_BALLOON_S_MEMTOT   5
> +#define VIRTIO_BALLOON_S_AVAIL    6
> +#define VIRTIO_BALLOON_S_CACHES   7
>          le16 tag;
>          le64 val;
>  } __attribute__((packed));
> @@ -5109,6 +5111,13 @@ first buffer.
>  
>  \item[VIRTIO_BALLOON_S_MEMTOT (5)] The total amount of memory available
>    (in bytes).
> +
> +\item[VIRTIO_BALLOON_S_AVAIL (6)] An estimate of how much memory is available
> +  (in bytes) for starting new applications, without pushing the system to swap.
> +
> +\item[VIRTIO_BALLOON_S_CACHES (7)] The amount of memory, in bytes, that can be
> +  quickly reclaimed without additional I/O. Typically these pages are used for
> +  caching files from disk.
>  \end{description}
>  
>  \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
> -- 
> 2.16.1

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

