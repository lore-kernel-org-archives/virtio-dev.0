Return-Path: virtio-return-3320-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 15 Mar 2019 14:59:53 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190314184224.19110-1-mst@redhat.com>
References: <20190314184224.19110-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190315145953.4072c907@oc2783563651>
Subject: Re: [virtio] [PATCH v5] conformance: fix confusion about legacy
 interface
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 14 Mar 2019 14:44:02 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Supercedes:
> 	"conformance: clarify transitional/non-transitional"

I don't think this is ought to be a part of the commit message.

> 
> The text describing the legacy interface also obliquely refers to a
> non-transitional implementation. This seems to cause confusion
> and there's no good reason to do it here: this section
> is about legacy interface and transitional devices,
> it add not value at all. Just drop it. We need to tweak
> wording in the next paragraph to avoid saying "additionally"
> since there's nothing to add to anymore.
> 
> Note: the spec does not make it clear whether description of the legacy
> interface is normative or not, and in particular, this section is not
> linked to from any conformance targets.
> Resolving that is left for after 1.1 since the text is not new
> and was already there in 1.0.

Sounds good.

> 
> VIRTIO-167
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  conformance.tex | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/conformance.tex b/conformance.tex
> index 6df113b..ce51463 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -341,13 +341,9 @@ A conformant implementation MUST be either transitional or
>  non-transitional, see \ref{intro:Legacy
>  Interface: Terminology}.
>  
> -A non-transitional implementation conforms to this specification
> -if it satisfies all of the MUST or REQUIRED level requirements
> -defined above.
> -
>  An implementation MAY choose to implement OPTIONAL support for the
>  legacy interface, including support for legacy drivers
> -or devices, by additionally conforming to all of the MUST or
> +or devices, by conforming to all of the MUST or
>  REQUIRED level requirements for the legacy interface
>  for the transitional devices and drivers.
>  

I pointed out some issues with the resulting text, but these are
remaining issues and not issues introduced by this change.

I'm quite happy with this change. With the commit message tweak:

Acked-by: Halil Pasic <pasic@linux.ibm.com>



---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

