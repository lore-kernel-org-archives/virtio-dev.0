Return-Path: virtio-return-3293-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 12 Mar 2019 16:00:41 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190311160018.29995-1-mst@redhat.com>
References: <20190311160018.29995-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190312160041.113d8779@oc2783563651>
Subject: [virtio] Re: [virtio-dev] [PATCH v3] conformance: clarify
 transitional/non-transitional
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 11 Mar 2019 12:00:46 -0400
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
> 
> Changes from v1:
> 	address remaining comments by Cornelia
> Changes from v1:
> 	address comments by Cornelia
> 
>  conformance.tex | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/conformance.tex b/conformance.tex
> index 1577c0c..c0df2a2 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -344,16 +344,26 @@ Interface: Terminology}.
>  
>  A non-transitional implementation conforms to this specification
>  if it satisfies all of the MUST or REQUIRED level requirements
> -defined above.
> +defined in section \ref{sec:Conformance / Conformance Targets} above.

I think 'above' is superfluous. 

>  
> -An implementation MAY choose to implement OPTIONAL support for the
> -legacy interface, including support for legacy drivers
> -or devices, by additionally conforming to all of the MUST or
> -REQUIRED level requirements for the legacy interface
> -for the transitional devices and drivers.
> +A transitional implementation conforms to this specification
> +if it satisfies all of the MUST or REQUIRED level requirements
> +defined in section \ref{sec:Conformance / Conformance Targets} above

I would prefer 'above' dropped, but no biggie.

> +and additionally implements the legacy interface
> +for devices and drivers, described in
> +\hyperref[intro:Virtio PCI Draft]{[Virtio PCI Draft]}.
>  
> -The requirements for the legacy interface for transitional implementations
> -are located in sections named ``Legacy Interface'' listed below:
> +\begin{note}
> +No normative specification for the legacy interface exists,
> +instead the ability of the device or the driver to inter-operate
> +with the existing body of devices and drivers is a quality of
> +implementation issue.
> +\end{note}

I don't like 'existing body of devices and drivers' because IMHO this is
only about legacy devices and drivers. I.e. an implementation that
conforms to this specification (or a previous version of this
specification) is guaranteed to be inter-operable. 

> +
> +To facilitate creating transitional implementations, as well as
> +to assist in converting legacy interfaces to conforming ones,
> +the requirements for the legacy interface for transitional implementations
> +are located in non-normative sections named ``Legacy Interface'' listed below:

I have a hard time to tell if this change makes transitional vs
non-transitional clearer or not.

I think there is a dissonance between 'no normative specification for
the legacy interface exists' and 'transitional implementation conforms
to this specification if ...'.

The latter suggests that based on this specification and the referenced
draft together do provide, what is necessary to decide if a given
implementation is a transitional implementation that conforms to this
specification.

The former suggests that only the non-transitional, i.e. virtio
conforming, part of the transitional device is actually well specified.
Please note that the non-normative sections do contain constructs that
are normally reserved for normative statements (e.g. MUST).

AFAIU a transitional implementation is any implementation that is
conforming to this specification and aims to provide some
inter-operability with some legacy implementations that do not conform
this specification. A non-transitional implementation is an
implementation that is conforms to this specification and does not care
about inter-operability with implementation that don not conform to this
specification.

I think people familiar with virtio already have a good understanding of
transitional and non-transitional. Because of this I'm going to abstain
on this.

Regards,
Halil



 



 



---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

