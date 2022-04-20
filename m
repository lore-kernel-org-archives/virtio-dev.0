Return-Path: <virtio-comment-return-2957-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220419163024.134007-1-mst@redhat.com>
References: <20220419163024.134007-1-mst@redhat.com>
Date: Wed, 20 Apr 2022 14:57:04 +0200
Message-ID: <87wnfj7w0v.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio-dev] [PATCH] fixupdiff: escape ^ caret
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> Since commit:
>
> commit 1e30753d53d222fbe955f0643583d756105d557e
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Fri Oct 11 13:43:41 2019 +0200
>
>     Fix ^= in example code
>
>     Trying to escaping ^ here only leaves the backslash in the output.
>
>     Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> we have plain ^ inside listing. Escape it with \ but only
> if not already escaped (as output of diff with old source will be).
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  fixupdiff.pl | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks, pushed as an editorial update.


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

