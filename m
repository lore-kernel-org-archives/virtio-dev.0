Return-Path: virtio-return-2969-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 6 Mar 2018 15:44:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180306154424.26d8e1f5.cohuck@redhat.com>
In-Reply-To: <1520346937-7968-1-git-send-email-mst@redhat.com>
References: <1520346937-7968-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH] introduction: add note on bitfield portability
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 6 Mar 2018 16:35:46 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

[You picked my old email address :)]

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  introduction.tex | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/introduction.tex b/introduction.tex
> index d0b770e..18ad76e 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -175,5 +175,12 @@ packed by C compilers on little-endian architectures but not the
>  way bitfields are packed by C compilers on big-endian
>  architectures.
>  
> +Assuming that CPU_TO_BE16 converts a 16-bit integer from a native
> +CPU to the big-endian byte order, the following is the equivalent
> +portable C code to generate a value in this format:
> +\begin{lstlisting}
> +CPU_TO_BE16(B << 15 | A)
> +\end{lstlisting}
> +
>  \newpage
>  

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

