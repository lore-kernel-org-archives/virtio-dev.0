Return-Path: virtio-return-3421-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 2 Dec 2019 18:32:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20191202183216.1c7c58ef.cohuck@redhat.com>
In-Reply-To: <20191202170744.256040-1-mst@redhat.com>
References: <20191202170744.256040-1-mst@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio] [PATCH] README.md: document use of virtio-dev
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 2 Dec 2019 12:08:08 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> People still seem to be confused which list is for what.
> Add a bit more text.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  README.md | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/README.md b/README.md
> index ffafb9b..1b72dc3 100644
> --- a/README.md
> +++ b/README.md
> @@ -157,6 +157,17 @@ issue is resolved under the minor cleanups standing rule.
>  and asking for a commit. </li>
>  </ol>
>  
> +<h4>Implementation discussion</h4>

s/discussion/discussions/ ?

> +Implementations should be discussed on the <strong>virtio-dev</strong> mailing list,
> +and are archived in the mailing list archives.

Maybe "Implementation discussions should happen on..."? Otherwise, this
sentence does not really make sense.

> +<p>See <A
> +HREF="https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback">
> +https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback</A>
> +<p>This is the correct list to copy on Linux virtio UAPI change proposals.
> +<p>Note that only plain text part of the message is archived, and all

s/plain text part/the plain text part/

(also in the description of virtio-comments)

> +attachments are stripped. Accordingly, messages sent to the
> +mailing list should use text/plain encoding and not
> +have any attachments.
>  <h3>Contact</h3>
>  <p>Please send questions or comments about <a href="https://www.oasis-open.org/resources/tcadmin/github-repositories-for-oasis-tc-members-chartered-work">OASIS TC GitHub repositories</a> to <a href="mailto:robin@oasis-open.org">Robin Cover</a> and <a href="mailto:chet.ensign@oasis-open.org">Chet Ensign</a>.  For questions about content in this repository, please contact the TC Chair or Co-Chairs as listed on the the virtio TC's <a href="https://www.oasis-open.org/committees/virtio/">home page</a>.</p>
>  </div>


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

