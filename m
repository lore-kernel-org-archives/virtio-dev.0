Return-Path: virtio-return-3380-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 23 Jul 2019 10:05:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190723100512.5a6b441a.cohuck@redhat.com>
In-Reply-To: <20190722203854.16494-1-mst@redhat.com>
References: <20190722203854.16494-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH] README.md: document github use
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 22 Jul 2019 16:39:39 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  README.md | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/README.md b/README.md
> index 3de0c1e..0aceb75 100644
> --- a/README.md
> +++ b/README.md
> @@ -69,6 +69,34 @@ in <A
>  HREF="https://github.com/oasis-tcs/virtio-admin">https://github.com/oasis-tcs/virtio-admin</A>.
>  
>  </div>
> +<h4>Use of github issues</h4>
> +Note: according to the virtio TC rules, all official TC communication
> +is taking on one of the TC mailing lists.

"is taking place" ?

> +In particular, all comments must be provided on
> +one of the TC mailing lists. Accordingly, the TC will not respond
> +to comments provided in github issues: github issues are
> +used solely to track integration of comments into the
> +specification.<p>
> +To request a TC vote on resolving a specific comment:
> +<ol>
> +<li>Create a github issue, or edit an existing issue, with
> +a short summary of the comment.
> +The issue MUST specify
> +the link to the latest proposal in the TC mailing list
> +archives. <em>Note:</em> the link MUST be in the issue description itself -
> +<em>not</em> in the comments.</li>
> +<li>Reply by email to the comment email, requesting that the TC vote
> +on resolving the issue.
> +The mail requesting the vote should include the following, on a line by itself:<br>
> +<code>
> +Fixes: https://github.com/oasis-tcs/virtio-spec/issues/NNN
> +</code>
> +(NNN is the issue number)</li>
> +<li>Please make sure to allow time after a comment resolving
> +an issue is posted and
> +before asking for a vote.</li>

Maybe reword as:

"Please make sure to allow some time between posting a comment
resolving an issue and asking for a vote." ?

Otherwise, this looks good to me.

> +</ol>
> +
>  <h3>Contact</h3>
>  <p>Please send questions or comments about <a href="https://www.oasis-open.org/resources/tcadmin/github-repositories-for-oasis-tc-members-chartered-work">OASIS TC GitHub repositories</a> to <a href="mailto:robin@oasis-open.org">Robin Cover</a> and <a href="mailto:chet.ensign@oasis-open.org">Chet Ensign</a>.  For questions about content in this repository, please contact the TC Chair or Co-Chairs as listed on the the virtio TC's <a href="https://www.oasis-open.org/committees/virtio/">home page</a>.</p>
>  </div>


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

