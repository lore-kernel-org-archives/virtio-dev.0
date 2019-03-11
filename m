Return-Path: virtio-return-3266-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 11 Mar 2019 15:37:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190311153739.28261a6b.cohuck@redhat.com>
In-Reply-To: <20190311132045.25232-1-mst@redhat.com>
References: <20190311132045.25232-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH] conformance: clarify
 transitional/non-transitional
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 11 Mar 2019 09:20:49 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Clarify that:
> - non-transitional just satisfy 3 main clauses
> - transitional also has a legacy interface:
>   however note that it's not an optional component
>   *for transitional devices* so MAY is inappropriate
> - legacy device descriptions are non-normative.
>   In fact virtio 0.9 is non-normative as a whole
>   and always was by design: it was early days and
>   spec evolved to document bugs in implementations.
> 
> VIRTIO-167
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  conformance.tex | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/conformance.tex b/conformance.tex
> index 1577c0c..518b9c7 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -344,16 +344,26 @@ Interface: Terminology}.
>  
>  A non-transitional implementation conforms to this specification
>  if it satisfies all of the MUST or REQUIRED level requirements
> -defined above.
> +defined in section \ref{sec:Conformance / Conformance Targets} above.
>  
> -An implementation MAY choose to implement OPTIONAL support for the
> -legacy interface, including support for legacy drivers
> -or devices, by additionally conforming to all of the MUST or
> -REQUIRED level requirements for the legacy interface
> -for the transitional devices and drivers.
> +A transitional implementation conforms to this specification
> +if it satisfies all of the MUST or REQUIRED level requirements
> +defined in section \ref{sec:Conformance / Conformance Targets} above
> +and additionally implements the legacy interface
> +for the transitional devices and drivers, described in

This "for the transitional devices and drivers" is a bit confusing
here, I think. s/for the transitional/for/ ?

> +\hyperref[intro:Virtio PCI Draft]{[Virtio PCI Draft]}.
>  
> -The requirements for the legacy interface for transitional implementations
> -are located in sections named ``Legacy Interface'' listed below:
> +\begin{note}
> +No normative specification for the legacy interface exists,
> +instead device and driver's ability to interoperate with

"instead the ability of the device or the driver to inter-operate
with" ?

> +the existing body of installed devices and drivers is a quality

s/installed// ?

> +of implementation issue.
> +\begin{note}

This needs to be \end{note}

> +
> +To facilitate creating transitional implementations, as well as
> +assist in converting legacy interfaces to conforming ones,

s/assist/to assist/ ?

> +the requirements for the legacy interface for transitional implementations
> +are located in non-normative sections named ``Legacy Interface'' listed below:
>  \begin{itemize}
>  \item Section \ref{sec:Basic Facilities of a Virtio Device /
>  Feature Bits / Legacy Interface: A Note on Feature Bits}


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

