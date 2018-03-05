Return-Path: virtio-return-2963-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 5 Mar 2018 15:20:35 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180305152035.6a64b499.cohuck@redhat.com>
In-Reply-To: <1519845375-28741-1-git-send-email-mst@redhat.com>
References: <1519845375-28741-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH] introduction: document bitfield notation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 28 Feb 2018 21:16:32 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Bitfields are a useful and familiar way to specify sub-byte structure
> layout. The only issue is that bitfield order isn't portable across
> architectures.  Document that we list bitfields from least to
> most significant one, and warn about portability issues.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  introduction.tex | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/introduction.tex b/introduction.tex
> index 979881e..3cb7a70 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -157,5 +157,23 @@ in little-endian byte order.
>  in big-endian byte order.
>  \end{description}
>  
> +When documenting sub-byte data fields, C-like bitfield notation
> +is used. Fields within an integer are always listed in order,
> +from the least significant to the most significant bit.
> +
> +For example:
> +\begin{lstlisting}
> +be16 A : 15;
> +be16 B : 1;
> +\end{lstlisting}
> +documents the value A stored in the low 15 bit of a 16 bit
> +integer and the value B stored in the high bit of the 16 bit
> +integer, the integer in turn using the big-endian byte order.
> +
> +Note that this notation typically matches the way bitfields are
> +packed by C compilers on little-endian architectures but not the
> +way bitfields are packed by C compilers on big-endian
> +architectures.
> +
>  \newpage
>  

I must admit that this explanation confuses me a bit. Would some kind
of graphic representation be more helpful?

For example, on s390 I would expect the structure to look like the
following:

|0  ..  14 | 15 |
|    A     |  B |

If you included another example for little-endian byte order, this
would clear up things more, I think.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

