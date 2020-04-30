Return-Path: virtio-comment-return-1202-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 30 Apr 2020 03:39:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200430033808-mutt-send-email-mst@kernel.org>
References: <20200327103803.10460-1-alex.bennee@linaro.org>
 <20200327103803.10460-2-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200327103803.10460-2-alex.bennee@linaro.org>
Subject: [virtio-comment] Re: [virtio-dev] [RFC PATCH  1/8] README.md: convert html to proper
 Markdown format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Robin Cover <robin@oasis-open.org>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Mar 27, 2020 at 10:37:56AM +0000, Alex Benn=C3=A9e wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I don't mind, but OASIS admins asked us to keep the boiler plate as is.
I assume it's fine as it's just re-formatting. Cc Robin Cover to make
sure.


> ---
>  README.md | 258 +++++++++++++++++++++---------------------------------
>  1 file changed, 100 insertions(+), 158 deletions(-)
>=20
> diff --git a/README.md b/README.md
> index 2bdf485..8bb10e0 100644
> --- a/README.md
> +++ b/README.md
> @@ -1,173 +1,115 @@
> -<div>
> -<h2>README</h2>
> +Members of the [OASIS Virtual I/O Device (VIRTIO) TC](https://www.oasis-=
open.org/committees/virtio/) create and manage technical content in this TC=
 GitHub repository ( [https://github.com/oasis-tcs/virtio-spec](https://git=
hub.com/oasis-tcs/virtio-spec) ) as part of the TC's chartered work (_i.e._=
, the program of work and deliverables described in its [charter](https://w=
ww.oasis-open.org/committees/virtio/charter.php)).
> =20
> -<p>Members of the <a href=3D"https://www.oasis-open.org/committees/virti=
o/">OASIS Virtual I/O Device (VIRTIO) TC</a> create and manage technical co=
ntent in this TC GitHub repository ( <a href=3D"https://github.com/oasis-tc=
s/virtio-spec">https://github.com/oasis-tcs/virtio-spec</a> ) as part of th=
e TC's chartered work (<i>i.e.</i>, the program of work and deliverables de=
scribed in its <a href=3D"https://www.oasis-open.org/committees/virtio/char=
ter.php">charter</a>).</p>
> +OASIS TC GitHub repositories, as described in [GitHub Repositories for O=
ASIS TC Members' Chartered Work](https://www.oasis-open.org/resources/tcadm=
in/github-repositories-for-oasis-tc-members-chartered-work), are governed b=
y the OASIS [TC Process](https://www.oasis-open.org/policies-guidelines/tc-=
process), [IPR Policy](https://www.oasis-open.org/policies-guidelines/ipr),=
 and other policies, similar to TC Wikis, TC JIRA issues tracking instances=
, TC SVN/Subversion repositories, etc. While they make use of public GitHub=
 repositories, these TC GitHub repositories are distinct from [OASIS Open R=
epositories](https://www.oasis-open.org/resources/open-repositories), which=
 are used for development of open source [licensed](https://www.oasis-open.=
org/resources/open-repositories/licenses) content.
> =20
> -<p>OASIS TC GitHub repositories, as described in <a href=3D"https://www.=
oasis-open.org/resources/tcadmin/github-repositories-for-oasis-tc-members-c=
hartered-work">GitHub Repositories for OASIS TC Members' Chartered Work</a>=
, are governed by the OASIS <a href=3D"https://www.oasis-open.org/policies-=
guidelines/tc-process">TC Process</a>, <a href=3D"https://www.oasis-open.or=
g/policies-guidelines/ipr">IPR Policy</a>, and other policies, similar to T=
C Wikis, TC JIRA issues tracking instances, TC SVN/Subversion repositories,=
 etc.  While they make use of public GitHub repositories, these TC GitHub r=
epositories are distinct from <a href=3D"https://www.oasis-open.org/resourc=
es/open-repositories">OASIS Open Repositories</a>, which are used for devel=
opment of open source <a href=3D"https://www.oasis-open.org/resources/open-=
repositories/licenses">licensed</a> content.</p>
> -</div>
> +### Description
> =20
> -<div>
> -<h3>Description</h3>
> +This repository includes the [authoritative source](https://github.com/o=
asis-tcs/virtio-spec/releases) of the VIRTIO (Virtual I/O) Specification do=
cument. VIRTIO document describes the specifications of the "virtio" family=
 of devices. These devices are found in virtual environments, yet by design=
 they look like physical devices to the guest within the virtual machine =
=E2=80=94 and this document treats them as such. This similarity allows the=
 guest to use standard drivers and discovery mechanisms.
> =20
> -<p>This repository includes the <a href=3D"https://github.com/oasis-tcs/=
virtio-spec/releases">authoritative source</a> of the VIRTIO (Virtual I/O) =
Specification document. VIRTIO document describes the specifications of the=
 "virtio" family of devices. These devices are found in virtual environment=
s, yet by design they look like physical devices to the guest within the vi=
rtual machine &mdash; and this document treats them as such. This similarit=
y allows the guest to use standard drivers and discovery mechanisms. </p>
> +The purpose of virtio and this specification is that virtual environment=
s and guests should have a straightforward, efficient, standard and extensi=
ble mechanism for virtual devices, rather than boutique per-environment or =
per-OS mechanisms.
> =20
> -<p>The purpose of virtio and this specification is that virtual environm=
ents and guests should have a straightforward, efficient, standard and exte=
nsible mechanism for virtual devices, rather than boutique per-environment =
or per-OS mechanisms.</p>
> -</div>
> +### Contributions
> =20
> -<div>
> -<h3>Contributions</h3>
> -<p>As stated in this repository's <a href=3D"https://github.com/oasis-tc=
s/virtio-spec/blob/master/CONTRIBUTING.md">CONTRIBUTING file</a>, contribut=
ors to this repository are expected to be Members of the OASIS virtio TC, f=
or any substantive change requests.  Anyone wishing to contribute to this G=
itHub project and <a href=3D"https://www.oasis-open.org/join/participation-=
instructions">participate</a> in the TC's technical activity is invited to =
join as an OASIS TC Member.  Public feedback is also accepted, subject to t=
he terms of the <a href=3D"https://www.oasis-open.org/policies-guidelines/i=
pr#appendixa">OASIS Feedback License</a>.</p>
> -</div>
> +As stated in this repository's [CONTRIBUTING file](https://github.com/oa=
sis-tcs/virtio-spec/blob/master/CONTRIBUTING.md), contributors to this repo=
sitory are expected to be Members of the OASIS virtio TC, for any substanti=
ve change requests. Anyone wishing to contribute to this GitHub project and=
 [participate](https://www.oasis-open.org/join/participation-instructions) =
in the TC's technical activity is invited to join as an OASIS TC Member. Pu=
blic feedback is also accepted, subject to the terms of the [OASIS Feedback=
 License](https://www.oasis-open.org/policies-guidelines/ipr#appendixa).
> =20
> +### Licensing
> =20
> +Please see the [LICENSE](https://github.com/oasis-tcs/virtio-spec/blob/m=
aster/LICENSE.md) file for description of the license terms and OASIS polic=
ies applicable to the TC's work in this GitHub project. Content in this rep=
ository is intended to be part of the virtio TC's permanent record of activ=
ity, visible and freely available for all to use, subject to applicable OAS=
IS policies, as presented in the repository [LICENSE](https://github.com/oa=
sis-tcs/virtio-spec/blob/master/LICENSE.md) file.
> =20
> -<div>
> -<h3>Licensing</h3>
> -<p>Please see the <a href=3D"https://github.com/oasis-tcs/virtio-spec/bl=
ob/master/LICENSE.md">LICENSE</a> file for description of the license terms=
 and OASIS policies applicable to the TC's work in this GitHub project. Con=
tent in this repository is intended to be part of the virtio TC's permanent=
 record of activity, visible and freely available for all to use, subject t=
o applicable OASIS policies, as presented in the repository <a href=3D"http=
s://github.com/oasis-tcs/virtio-spec/blob/master/LICENSE.md">LICENSE</a> fi=
le.</p>
> -</div>
> +### Further Description of this Repository
> =20
> -<div>
> +#### Building Instructions
> =20
> -<h3>Further Description of this Repository</h3>
> -<h4>Building Instructions</h4>
> -Authoritative version of the specification is maintained in the
> -TeX document format. PDF and HTML versions are made available for
> -ease of use and review.
> -In order to build the HTML and PDF versions of the spec you will need th=
e
> -TeX document production system.
> -The easiest way to get it up and running is probably by installing
> -<a href=3D"https://www.tug.org/texlive/">Tex-Live</a>.
> +Authoritative version of the specification is maintained in the TeX docu=
ment format. PDF and HTML versions are made available for ease of use and r=
eview. In order to build the HTML and PDF versions of the spec you will nee=
d the TeX document production system. The easiest way to get it up and runn=
ing is probably by installing [Tex-Live](https://www.tug.org/texlive/).
> +
> +Installation cheat sheet:
> +
> +Fedora:
> +
> +`sudo dnf install texlive-scheme-full`
> =20
> -<dl>Installation cheat sheet:
> -<dt>Fedora:</dt>
> -<dd>
> -<code>
> -sudo dnf install texlive-scheme-full
> -</code></dd>
> -<dt>
>  Ubuntu and other Debian derivatives:
> -</dt>
> -<dd>
> -<code>
> -sudo apt-get install texlive-full
> -</code></dd>
> -<dt>OSX:<dt>
> -<dd>OSX users don't need to install Tex-Live because they already have
> -<a href=3D"http://www.tug.org/mactex/">MacTeX</a> installed.
> -</dd>
> -</dl>
> -<dl>The build process generates a ZIP package file including the
> -original TeX sources, as well as HTML and PDF formatted
> -versions of the specification.
> -<dt>To generate the ZIP package, run:<dt>
> -<dd>
> -<code>
> -./makeall.sh
> -</code>
> -</dd>
> -<dt>Troubleshooting notes:</dt>
> -<dd> PDFs of the specification can be generated with
> -either MicroSoft's Core fonts for the Web: Arial and Courier New,
> -or Liberation fonts: Liberation Sans and Liberation Mono.
> -Most systems come with one of these two variants included:
> -should you get an error message about missing fonts,
> -you will need to downloads and install one of the above
> -font packages.
> -<dd>
> -</dl>
> -<h4>Providing Feedback</h4>
> -Feedback must be provided the <strong>virtio-comment</strong> mailing li=
st,
> -and archived in the mailing list archives.
> -<p>See <A
> -HREF=3D"https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=3Dvi=
rtio#feedback">
> -https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=3Dvirtio#fee=
dback</A>
> -<p>Note that only plain text part of the message is archived, and all
> -attachments are stripped. Accordingly, messages sent to the
> -mailing list should use text/plain encoding and not
> -have any attachments.
> -<p>The preferred form of providing feedback is in form of a patch.
> -A patch can be generated and sent by cloning the spec repository,
> -creating a commit, formatting it as a patch and then sending it.
> -For example:
> -<code>
> -<p>
> -git clone https://github.com/oasis-tcs/virtio-spec.git<br>
> -... edit spec text, and save ...<br>
> -<p>
> -git commit -a<br>
> -... describe the proposed change, in the following format:<br>
> -single line summary<br>
> -<br>
> -detailed description, including motivation for the change<br>
> -<br>
> -Signed-off-by: Name &lt;email&gt;<br>
> -... then save and close the editor ... <br>
> -<p>
> -git format-patch -o proposal1/ HEAD~1..<br>
> -... generates a new directory proposal1/ and a file starting with 0001- =
...<br>
> -<p>
> -git send-email --to=3Dvirtio-comment@lists.oasis-open.org proposal1/0001=
-*
> -</code>
> -<h4>Note for TC Members</h4>
> -<p>TC Members should review TC specific
> -process rules under "Further Description of this Repository"
> -in <A
> -HREF=3D"https://github.com/oasis-tcs/virtio-admin">https://github.com/oa=
sis-tcs/virtio-admin</A>.
> -
> -</div>
> -<h4>Implementation discussion</h4>
> -Implementation discussion should take place on the <strong>virtio-dev</s=
trong> mailing list,
> -and be archived in the mailing list archives.
> -<p>See <A
> -HREF=3D"https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=3Dvi=
rtio#feedback">
> -https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=3Dvirtio#fee=
dback</A>
> -<p>This is the correct list to copy on Linux virtio UAPI change proposal=
s.
> -<p>Note that only the plain text part of the message is archived, and al=
l
> -attachments are stripped. Accordingly, messages sent to the
> -mailing list should use text/plain encoding and not
> -have any attachments.
> -<h4>Use of github issues</h4>
> -Note: according to the virtio TC rules, all official TC communication
> -is taking place on one of the TC mailing lists.
> -In particular, all comments must be provided on
> -one of the TC mailing lists. Accordingly, the TC will not respond
> -to comments provided in github issues: github issues are
> -used solely to track integration of comments into the
> -specification.<p>
> +
> +`sudo apt-get install texlive-full`
> +
> +OSX:
> +
> +OSX users don't need to install Tex-Live because they already have [MacT=
eX](http://www.tug.org/mactex/) installed.
> +
> +The build process generates a ZIP package file including the original Te=
X sources, as well as HTML and PDF formatted versions of the specification.
> +
> +To generate the ZIP package, run:
> +
> +`./makeall.sh`
> +
> +Troubleshooting notes:
> +
> +PDFs of the specification can be generated with either MicroSoft's Core =
fonts for the Web: Arial and Courier New, or Liberation fonts: Liberation S=
ans and Liberation Mono. Most systems come with one of these two variants i=
ncluded: should you get an error message about missing fonts, you will need=
 to downloads and install one of the above font packages.
> +
> +#### Providing Feedback
> +
> +Feedback must be provided the **virtio-comment** mailing list, and archi=
ved in the mailing list archives.
> +
> +See [https://www.oasis-open.org/committees/tc\_home.php?wg\_abbrev=3Dvir=
tio#feedback](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=
=3Dvirtio#feedback)
> +
> +Note that only plain text part of the message is archived, and all attac=
hments are stripped. Accordingly, messages sent to the mailing list should =
use text/plain encoding and not have any attachments.
> +
> +The preferred form of providing feedback is in form of a patch. A patch =
can be generated and sent by cloning the spec repository, creating a commit=
, formatting it as a patch and then sending it. For example:
> +
> +`git clone https://github.com/oasis-tcs/virtio-spec.git =20
> +... edit spec text, and save ... =20
> +`
> +
> +`git commit -a =20
> +... describe the proposed change, in the following format: =20
> +single line summary =20
> + =20
> +detailed description, including motivation for the change =20
> + =20
> +Signed-off-by: Name <email> =20
> +... then save and close the editor ... =20
> +`
> +
> +`git format-patch -o proposal1/ HEAD~1.. =20
> +... generates a new directory proposal1/ and a file starting with 0001- =
... =20
> +`
> +
> +`git send-email --to=3Dvirtio-comment@lists.oasis-open.org proposal1/000=
1-*`
> +
> +#### Note for TC Members
> +
> +TC Members should review TC specific process rules under "Further Descri=
ption of this Repository" in [https://github.com/oasis-tcs/virtio-admin](ht=
tps://github.com/oasis-tcs/virtio-admin).
> +
> +#### Implementation discussion
> +
> +Implementation discussion should take place on the **virtio-dev** mailin=
g list, and be archived in the mailing list archives.
> +
> +See [https://www.oasis-open.org/committees/tc\_home.php?wg\_abbrev=3Dvir=
tio#feedback](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=
=3Dvirtio#feedback)
> +
> +This is the correct list to copy on Linux virtio UAPI change proposals.
> +
> +Note that only the plain text part of the message is archived, and all a=
ttachments are stripped. Accordingly, messages sent to the mailing list sho=
uld use text/plain encoding and not have any attachments.
> +
> +#### Use of github issues
> +
> +Note: according to the virtio TC rules, all official TC communication is=
 taking place on one of the TC mailing lists. In particular, all comments m=
ust be provided on one of the TC mailing lists. Accordingly, the TC will no=
t respond to comments provided in github issues: github issues are used sol=
ely to track integration of comments into the specification.
> +
>  To request a TC vote on resolving a specific comment:
> -<ol>
> -<li>Create a github issue, or edit an existing issue, with
> -a short summary of the comment.
> -The issue MUST specify
> -the link to the latest proposal in the TC mailing list
> -archives. <em>Note:</em> the link MUST be in the issue description itsel=
f -
> -<em>not</em> in the comments.</li>
> -<li>Reply by email to the comment email, requesting that the TC vote
> -on resolving the issue.
> -The mail requesting the vote should include the following, on a line by =
itself:<br>
> -<code>
> -Fixes: https://github.com/oasis-tcs/virtio-spec/issues/NNN
> -</code>
> -(NNN is the issue number)</li>
> -<li>Please make sure to allow time for review between posting a comment
> -and asking for a vote. </li>
> -</ol>
> -<h4>TC standing rules</h4>
> +
> +1.  Create a github issue, or edit an existing issue, with a short summa=
ry of the comment. The issue MUST specify the link to the latest proposal i=
n the TC mailing list archives. _Note:_ the link MUST be in the issue descr=
iption itself - _not_ in the comments.
> +2.  Reply by email to the comment email, requesting that the TC vote on =
resolving the issue. The mail requesting the vote should include the follow=
ing, on a line by itself: =20
> +    `Fixes: https://github.com/oasis-tcs/virtio-spec/issues/NNN` (NNN is=
 the issue number)
> +3.  Please make sure to allow time for review between posting a comment =
and asking for a vote.
> +
> +#### TC standing rules
> +
>  The TC adopted the following standing rule:
> -<p>
> -<em>
> -Minor cleanups, including editorial formatting changes, spelling
> -and typo fixes can be committed directly into git for approval as
> -part of the next specification approval ballot.
> -</em>
> -<ol>
> -<li>To request such a commit, reply by email to the comment email, reque=
sting that the
> -issue is resolved under the minor cleanups standing rule.
> -</li>
> -<li>Please make sure to allow time for review between posting a comment
> -and asking for a commit. </li>
> -</ol>
> -
> -<h3>Contact</h3>
> -<p>Please send questions or comments about <a href=3D"https://www.oasis-=
open.org/resources/tcadmin/github-repositories-for-oasis-tc-members-charter=
ed-work">OASIS TC GitHub repositories</a> to <a href=3D"mailto:robin@oasis-=
open.org">Robin Cover</a> and <a href=3D"mailto:chet.ensign@oasis-open.org"=
>Chet Ensign</a>.  For questions about content in this repository, please c=
ontact the TC Chair or Co-Chairs as listed on the the virtio TC's <a href=
=3D"https://www.oasis-open.org/committees/virtio/">home page</a>.</p>
> -</div>
> +
> +_Minor cleanups, including editorial formatting changes, spelling and ty=
po fixes can be committed directly into git for approval as part of the nex=
t specification approval ballot._
> +
> +1.  To request such a commit, reply by email to the comment email, reque=
sting that the issue is resolved under the minor cleanups standing rule.
> +2.  Please make sure to allow time for review between posting a comment =
and asking for a commit.
> +
> +### Contact
> +
> +Please send questions or comments about [OASIS TC GitHub repositories](h=
ttps://www.oasis-open.org/resources/tcadmin/github-repositories-for-oasis-t=
c-members-chartered-work) to [Robin Cover](mailto:robin@oasis-open.org) and=
 [Chet Ensign](mailto:chet.ensign@oasis-open.org). For questions about cont=
ent in this repository, please contact the TC Chair or Co-Chairs as listed =
on the the virtio TC's [home page](https://www.oasis-open.org/committees/vi=
rtio/).
> --=20
> 2.20.1
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


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

