Return-Path: virtio-comment-return-796-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 12 Jul 2019 10:58:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190712105839.14e60378.cohuck@redhat.com>
In-Reply-To: <20190710183212.29420-3-dgilbert@redhat.com>
References: <20190710183212.29420-1-dgilbert@redhat.com>
	<20190710183212.29420-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-comment] Re: [PATCH v6 2/5] pci: Define id field
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redhat.com, vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 10 Jul 2019 19:32:09 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> For the virtio-fs device we require multiple large shared memory
> regions.  Differentiate these by an 'id' field in the base capability.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  content.tex | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

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

