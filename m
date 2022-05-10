Return-Path: <virtio-comment-return-3003-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220510052929.69133-1-mst@redhat.com>
References: <20220510052929.69133-1-mst@redhat.com>
Date: Tue, 10 May 2022 10:17:36 +0200
Message-ID: <87ee113iov.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio-dev] [PATCH] changelog editorial fixes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org, Paul Knight <paul.knight@oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 10 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> Paul Knight reports:
>
> Minor broken links in the "Revision History" - Appendix D
> - https://lists.oasis-open.org/archives/virtio-dev/201910/msg00057.html. =
(bad
> link due to inclusion of the terminating period - second item dated 01 Se=
p 2020
> in Appendix D Revision history) - not a blocking issue
> - =C2=A0https://lkml.org/lkml/2020/4/21/1020) (bad link due to including =
the final
> right parenthesis in the hyperlink - item dated 01 Sep 2020 by Petre Efti=
me) -
> not a blocking issue

These two are obvious formatting issues, which we may try to catch in
post-processing going forward.

> - https://github.org/oasis-tcs/virtio-spec/issues/97 =C2=A0(bad link due =
to using
> github.org instead of github.com - first item dated 30 Mar 2021 in Append=
ix D
> Revision history) - not a blocking issue

That error was pre-existing in the commit message the changelog had been
generated from -- we can fix it here (we can't fix it in the git
history); going forward, should we always try to fixup links for the
changelog? I imagine that links may end up in history that break later on.

>
> Reported-by: Paul Knight <paul.knight@oasis-open.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  cl-os.tex | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Anyway,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

