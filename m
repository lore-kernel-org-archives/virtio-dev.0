Return-Path: virtio-comment-return-1761-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20210316211311.154117-1-mst@redhat.com>
In-Reply-To: <20210316211311.154117-1-mst@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 Mar 2021 18:59:15 +0100
Message-ID: <CAJaqyWcXxHvFo2saNDkr+pj-wzUzVEvGy2GyewOzpAbXW2ZDqw@mail.gmail.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH] introduction: document #define syntax
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 16, 2021 at 10:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> We use the C #define syntax to refer to numeric values.
> Let's document that.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  introduction.tex | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/introduction.tex b/introduction.tex
> index cc38e29..4febed2 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -210,6 +210,27 @@ \section{Structure Specifications}
>  \begin{lstlisting}
>  CPU_TO_BE16(B << 15 | A)
>  \end{lstlisting}
> +\section{Constant Specifications}
> +
> +In many cases, numberic values used in the interface between the device
> +and the driver are documented using the C #define and /* */
> +comment syntax. Multiple related values are grouped together with
> +a common name as a prefix, using _ as a separator.
> +Using _XXX as a suffix refers to all values in a group.
> +For example:
> +
> +\begin{lstlisting}
> +/* Value A description */
> +#define VIRTIO_VALUE_A        (1 << 0)
> +/* Value B description */
> +#define VIRTIO_VALUE_B        (1 << 1)
> +\end{lstlisting}
> +documents two numeric values: 1 meaning Value A and 2 meaning
> +Value B.  Note that $<<$ refers to the shift-left operation.

I'm not sure if somebody can be confused about this, but maybe
s/shift-left operation/shift-left bitwise operation/ is more clear?

> +
> +Further, in this case VIRTIO_VALUE_A and VIRTIO_VALUE_B
> +refer to 1 and 2 respectively. Further, VIRTIO_VALUE_XXX refers to
> +either VIRTIO_VALUE_A or VIRTIO_VALUE_B.
>
>  \newpage
>
> --
> MST
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

