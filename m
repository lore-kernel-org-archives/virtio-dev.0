Return-Path: virtio-comment-return-1307-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <159055235065.209072.12017445428967301686.stgit@ahduyck-workstation>
 <159055240999.209072.325801657165111674.stgit@ahduyck-workstation>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1fc7b0ba-4af8-8161-d683-a28e9502a70a@redhat.com>
Date: Fri, 29 May 2020 10:13:15 +0200
MIME-Version: 1.0
In-Reply-To: <159055240999.209072.325801657165111674.stgit@ahduyck-workstation>
Content-Language: en-US
Subject: Re: [virtio-comment] [PATCH v4 1/3] content: Document balloon feature
 page poison
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>, mst@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 27.05.20 06:06, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>=20
> Page poison provides a way for the guest to notify the host that it is
> initializing or poisoning freed pages with some specific poison value. As=
 a
> result of this we can infer a couple traits about the guest:
>=20
> 1. Free pages will contain a specific pattern within the guest.
> 2. Modifying free pages from this value may cause an error in the guest.
> 3. Pages will be immediately written to by the driver when deflated.
>=20
> There are currently no existing features that make use of this data. In t=
he
> upcoming feature free page reporting we will need to make use of this to
> identify if we can evict pages from the guest without causing data
> corruption.
>=20
> Add documentation for the page poison feature describing the basic
> functionality and requirements.
>=20
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  conformance.tex |    2 ++
>  content.tex     |   59 +++++++++++++++++++++++++++++++++++++++++++++++++=
++----
>  2 files changed, 57 insertions(+), 4 deletions(-)
>=20
> diff --git a/conformance.tex b/conformance.tex
> index b6fdec090383..4ed9d62e8088 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -149,6 +149,7 @@ \section{Conformance Targets}\label{sec:Conformance /=
 Conformance Targets}
>  \item \ref{drivernormative:Device Types / Memory Balloon Device / Featur=
e bits}
>  \item \ref{drivernormative:Device Types / Memory Balloon Device / Device=
 Operation}
>  \item \ref{drivernormative:Device Types / Memory Balloon Device / Device=
 Operation / Memory Statistics}
> +\item \ref{drivernormative:Device Types / Memory Balloon Device / Device=
 Operation / Page Poison}
>  \end{itemize}
> =20
>  \conformance{\subsection}{SCSI Host Driver Conformance}\label{sec:Confor=
mance / Driver Conformance / SCSI Host Driver Conformance}
> @@ -331,6 +332,7 @@ \section{Conformance Targets}\label{sec:Conformance /=
 Conformance Targets}
>  \item \ref{devicenormative:Device Types / Memory Balloon Device / Featur=
e bits}
>  \item \ref{devicenormative:Device Types / Memory Balloon Device / Device=
 Operation}
>  \item \ref{devicenormative:Device Types / Memory Balloon Device / Device=
 Operation / Memory Statistics}
> +\item \ref{devicenormative:Device Types / Memory Balloon Device / Device=
 Operation / Page Poison}
>  \end{itemize}
> =20
>  \conformance{\subsection}{SCSI Host Device Conformance}\label{sec:Confor=
mance / Device Conformance / SCSI Host Device Conformance}
> diff --git a/content.tex b/content.tex
> index 91735e3eb018..4a0ab90260ff 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5019,6 +5019,9 @@ \subsection{Feature bits}\label{sec:Device Types / =
Memory Balloon Device / Featu
>      memory statistics is present.
>  \item[VIRTIO_BALLOON_F_DEFLATE_ON_OOM (2) ] Deflate balloon on
>      guest out of memory condition.
> +\item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] A hint to the device, that the =
driver
> +    will immediately write \field{poison_val} to pages after deflating t=
hem.
> +    Configuration field \field{poison_val} is valid.
> =20

Here we have "that the driver will immediately" ...

But we never document that in form of a normative statement (e.g., "The
driver MUST initialize pages with \field{poison_val} after deflating").

Just wondering if that is intended (I imagine it will be different with
free page reporting)?

Apart from that looks good to me!

--=20
Thanks,

David / dhildenb


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

