Return-Path: virtio-return-3580-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 8 Apr 2021 22:18:13 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20210408221813.7796697c.pasic@linux.ibm.com>
In-Reply-To: <20210318182314.163060-1-mst@redhat.com>
References: <20210318182314.163060-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [virtio-comment] [PATCH v2] introduction: document #define
 syntax
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 18 Mar 2021 14:23:33 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> We use the C #define syntax to refer to numeric values.
> Let's document that.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>=20
> changes from v1:
> address Cornelia's comments
>=20
>=20
>  introduction.tex | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/introduction.tex b/introduction.tex
> index cc38e29..47bebf5 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -210,6 +210,29 @@ \section{Structure Specifications}
>  \begin{lstlisting}
>  CPU_TO_BE16(B << 15 | A)
>  \end{lstlisting}
> +\section{Constant Specifications}
> +
> +In many cases, numeric values used in the interface between the device
> +and the driver are documented using the C #define and /* */
> +comment syntax. Multiple related values are grouped together with
> +a common name as a prefix, using _ as a separator.
> +Using _XXX as a suffix refers to all values in a group.
> +For example:
> +
> +\begin{lstlisting}
> +/* Field Fld value A description */
> +#define VIRTIO_FLD_A        (1 << 0)
> +/* Field Fld value B description */
> +#define VIRTIO_FLD_B        (1 << 1)
> +\end{lstlisting}
> +documents two numeric values for a field \field{Fld}, with
> +\field{Fld} having value 1 referring to \field{A} and \field{Fld}
> +having value 2 referring to \field{B}.
> +Note that $<<$ refers to the shift-left operation.
> +
> +Further, in this case VIRTIO_FLD_A and VIRTIO_FLD_B
> +refer to values 1 and 2 of Fld respectively. Further, VIRTIO_FLD_XXX ref=
ers to
> +either VIRTIO_FLD_A or VIRTIO_FLD_B.

IMHO we also use the define stuff to do flags, and that does not match
nicely with the above sentence, since VIRTIO_FLD_F_A does not mean that
the FLD_F field has value A if we are trying to specify a flag or a
feature bit. And the left-shift is actually most common in these cases.

I'm not opposed to this change. In the virtio spec we tend to not be
very rigorous about formalism, and I came to accept that as a given.
Just wanted to point it out.

Sorry for not commenting on this sooner.

Regards,
Halil
> =20
>  \newpage
> =20


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

