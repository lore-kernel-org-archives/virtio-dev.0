Return-Path: <mst@redhat.com>
Date: Sat, 24 Dec 2022 13:17:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] RE: [PATCH v8 8/9] admin: command list discovery
Message-ID: <20221224131156-mutt-send-email-mst@kernel.org>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-9-mst@redhat.com>
 <SN6PR11MB3517ECBE658C18BD9B7E355CFF0A9@SN6PR11MB3517.namprd11.prod.outlook.com>
 <20221215023955-mutt-send-email-mst@kernel.org>
 <SN6PR11MB351785B5196165709E603082FFE19@SN6PR11MB3517.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <SN6PR11MB351785B5196165709E603082FFE19@SN6PR11MB3517.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Uminski, Piotr" <Piotr.Uminski@intel.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Jani, Nrupal" <nrupal.jani@intel.com>, "Yuan, Hang" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Dec 15, 2022 at 09:52:07AM +0000, Uminski, Piotr wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > 
> > On Mon, Nov 21, 2022 at 11:06:14AM +0000, Uminski, Piotr wrote:
> > > Instead of a bit-coded list of supported commands, can we just use an
> > array of supported command values? It allows us to use non-contiguous
> > command coding and checking how big  is an array:       le32
> > device_admin_cmds[];
> > 
> > Interesting, what's the usecase exactly?
> In some protocols command IDs are grouped, for example:
> 	Commands 0-99: standard device management
> 	Commands 100 - 199: vendor-specific device management
> 	Commands 200 - 299: standard queue management
> 	Commands 300 - 399: vendor-specific queue management
> Initially in each group only some command IDs are used. It makes it easier to add new commands later.
> > I don't really expect more than order or 200 commands - about 8 dwords.
> Agree that the number of commands will not be big. However if we define a command #1 (say standard one) and command #100 (say vendor-specific), we need to use 4 dwords for 2 commands anyway. 

which doesn't seem big.


I do think I see an issue though in that the driver does not currently
know whether the command buffer was truncated.  It sounds like a useful
piece of information at least for debugging.  I am thinking of adding a
"max-inbuf" value for device to return to driver (together with the
status) but it looks like it will typically repeat the used buffer size
- and duplicating values leads to bugs.

Better ideas?




> > And the operation we normally need is checking whether a given command
> > is supported, with a list that will be a slow lookup.
> I don't think that is a significant difference - this is once-per-initialization operation.
> 
> > Besides with your idea driver first needs to check how many commands are
> > supported, then do the query - two roundtrips to device.
> Right - this is the main disadvantage of my proposal.
> 
> > With the proposed interface, driver just allocates a buffer for commands it
> > knows about. Device truncates the buffer to the length supplied by driver, so
> > any commands outside the buffer are ignored.
> > 
> > --
> > MST
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.
> 
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/

