Return-Path: virtio-dev-return-3250-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C917581815E
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Feb 2018 07:56:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180221095159.GA1996@nanopsycho>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
 <20180220104224.GA2031@nanopsycho> <CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
 <20180220162933.GD2031@nanopsycho> <509bbbf9-4db7-dc78-a05e-403452a7407a@intel.com>
 <20180220201410.GF2031@nanopsycho> <20180220143356.3467084d@cakuba.netronome.com>
 <20180221095159.GA1996@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 21 Feb 2018 07:56:48 -0800
Message-ID: <CAKgT0UdyhrVr=pYZb=AJq9sWWUVb_BadbJTcqY1AwHHTw8cmQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 21, 2018 at 1:51 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Tue, Feb 20, 2018 at 11:33:56PM CET, kubakici@wp.pl wrote:
>>On Tue, 20 Feb 2018 21:14:10 +0100, Jiri Pirko wrote:
>>> Yeah, I can see it now :( I guess that the ship has sailed and we are
>>> stuck with this ugly thing forever...
>>>
>>> Could you at least make some common code that is shared in between
>>> netvsc and virtio_net so this is handled in exacly the same way in both?
>>
>>IMHO netvsc is a vendor specific driver which made a mistake on what
>>behaviour it provides (or tried to align itself with Windows SR-IOV).
>>Let's not make a far, far more commonly deployed and important driver
>>(virtio) bug-compatible with netvsc.
>
> Yeah. netvsc solution is a dangerous precedent here and in my opinition
> it was a huge mistake to merge it. I personally would vote to unmerge it
> and make the solution based on team/bond.
>
>
>>
>>To Jiri's initial comments, I feel the same way, in fact I've talked to
>>the NetworkManager guys to get auto-bonding based on MACs handled in
>>user space.  I think it may very well get done in next versions of NM,
>>but isn't done yet.  Stephen also raised the point that not everybody is
>>using NM.
>
> Can be done in NM, networkd or other network management tools.
> Even easier to do this in teamd and let them all benefit.
>
> Actually, I took a stab to implement this in teamd. Took me like an hour
> and half.
>
> You can just run teamd with config option "kidnap" like this:
> # teamd/teamd -c '{"kidnap": true }'
>
> Whenever teamd sees another netdev to appear with the same mac as his,
> or whenever teamd sees another netdev to change mac to his,
> it enslaves it.
>
> Here's the patch (quick and dirty):
>
> Subject: [patch teamd] teamd: introduce kidnap feature
>
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>

So this doesn't really address the original problem we were trying to
solve. You asked earlier why the netdev name mattered and it mostly
has to do with configuration. Specifically what our patch is
attempting to resolve is the issue of how to allow a cloud provider to
upgrade their customer to SR-IOV support and live migration without
requiring them to reconfigure their guest. So the general idea with
our patch is to take a VM that is running with virtio_net only and
allow it to instead spawn a virtio_bypass master using the same netdev
name as the original virtio, and then have the virtio_net and VF come
up and be enslaved by the bypass interface. Doing it this way we can
allow for multi-vendor SR-IOV live migration support using a guest
that was originally configured for virtio only.

The problem with your solution is we already have teaming and bonding
as you said. There is already a write-up from Red Hat on how to do it
(https://access.redhat.com/documentation/en-us/red_hat_virtualization/4.1/html/virtual_machine_management_guide/sect-migrating_virtual_machines_between_hosts).
That is all well and good as long as you are willing to keep around
two VM images, one for virtio, and one for SR-IOV with live migration.
The problem is nobody wants to do that. What they want is to maintain
one guest image and if they decide to upgrade to SR-IOV they still
want their live migration and they don't want to have to reconfigure
the guest.

That said it does seem to make the existing Red Hat solution easier to
manage since you wouldn't be guessing at ifname so I have provided
some feedback below.

> ---
>  include/team.h             |  7 +++++++
>  libteam/ifinfo.c           | 20 ++++++++++++++++++++
>  teamd/teamd.c              | 17 +++++++++++++++++
>  teamd/teamd.h              |  5 +++++
>  teamd/teamd_events.c       | 17 +++++++++++++++++
>  teamd/teamd_ifinfo_watch.c |  9 +++++++++
>  teamd/teamd_per_port.c     |  7 ++++++-
>  7 files changed, 81 insertions(+), 1 deletion(-)
>
> diff --git a/include/team.h b/include/team.h
> index 9ae517d..b0c19c8 100644
> --- a/include/team.h
> +++ b/include/team.h
> @@ -137,6 +137,13 @@ struct team_ifinfo *team_get_next_ifinfo(struct team_handle *th,
>  #define team_for_each_ifinfo(ifinfo, th)                       \
>         for (ifinfo = team_get_next_ifinfo(th, NULL); ifinfo;   \
>              ifinfo = team_get_next_ifinfo(th, ifinfo))
> +
> +struct team_ifinfo *team_get_next_unlinked_ifinfo(struct team_handle *th,
> +                                                 struct team_ifinfo *ifinfo);
> +#define team_for_each_unlinked_ifinfo(ifinfo, th)                      \
> +       for (ifinfo = team_get_next_unlinked_ifinfo(th, NULL); ifinfo;  \
> +            ifinfo = team_get_next_unlinked_ifinfo(th, ifinfo))
> +
>  /* ifinfo getters */
>  bool team_is_ifinfo_removed(struct team_ifinfo *ifinfo);
>  uint32_t team_get_ifinfo_ifindex(struct team_ifinfo *ifinfo);
> diff --git a/libteam/ifinfo.c b/libteam/ifinfo.c
> index 5c32a9c..8f9548e 100644
> --- a/libteam/ifinfo.c
> +++ b/libteam/ifinfo.c
> @@ -494,6 +494,26 @@ struct team_ifinfo *team_get_next_ifinfo(struct team_handle *th,
>         return NULL;
>  }
>
> +/**
> + * @param th           libteam library context
> + * @param ifinfo       ifinfo structure
> + *
> + * @details Get next unlinked ifinfo in list.
> + *
> + * @return Ifinfo next to ifinfo passed.
> + **/
> +TEAM_EXPORT
> +struct team_ifinfo *team_get_next_unlinked_ifinfo(struct team_handle *th,
> +                                                 struct team_ifinfo *ifinfo)
> +{
> +       do {
> +               ifinfo = list_get_next_node_entry(&th->ifinfo_list, ifinfo, list);
> +               if (ifinfo && !ifinfo->linked)
> +                       return ifinfo;
> +       } while (ifinfo);
> +       return NULL;
> +}
> +
>  /**
>   * @param ifinfo       ifinfo structure
>   *
> diff --git a/teamd/teamd.c b/teamd/teamd.c
> index aac2511..069c7f0 100644
> --- a/teamd/teamd.c
> +++ b/teamd/teamd.c
> @@ -926,8 +926,25 @@ static int teamd_event_watch_port_added(struct teamd_context *ctx,
>         return 0;
>  }
>
> +static int teamd_event_watch_unlinked_hwaddr_changed(struct teamd_context *ctx,
> +                                                    struct team_ifinfo *ifinfo,
> +                                                    void *priv)
> +{
> +       int err;
> +       bool kidnap;
> +
> +       err = teamd_config_bool_get(ctx, &kidnap, "$.kidnap");
> +       if (err || !kidnap ||
> +           ctx->hwaddr_len != team_get_ifinfo_hwaddr_len(ifinfo) ||
> +           memcmp(team_get_ifinfo_hwaddr(ifinfo),
> +                  ctx->hwaddr, ctx->hwaddr_len))
> +               return 0;
> +       return teamd_port_add(ctx, team_get_ifinfo_ifindex(ifinfo));
> +}
> +

So I am not sure about the name of this function. It seems to imply
that we want to capture a device if it changed its MAC address to
match the one we are using. I suppose that works if we are making this
a genreric thing that can run on any netdev, but our focus is virtio
and VFs. In the grand scheme of things they shouldn't be able to
change their MAC address in most environments that we will care about.
That was one of the reasons why we didn't bother supporting a MAC
change in our code since the hypervisor should have this locked and
attempting to use a different MAC address would likely trigger the VM
as being flagged as malicious.

>  static const struct teamd_event_watch_ops teamd_port_watch_ops = {
>         .port_added = teamd_event_watch_port_added,
> +       .unlinked_hwaddr_changed = teamd_event_watch_unlinked_hwaddr_changed,
>  };
>
>  static int teamd_port_watch_init(struct teamd_context *ctx)
> diff --git a/teamd/teamd.h b/teamd/teamd.h
> index 5dbfb9b..171a8d1 100644
> --- a/teamd/teamd.h
> +++ b/teamd/teamd.h
> @@ -189,6 +189,8 @@ struct teamd_event_watch_ops {
>                                    struct teamd_port *tdport, void *priv);
>         int (*port_ifname_changed)(struct teamd_context *ctx,
>                                    struct teamd_port *tdport, void *priv);
> +       int (*unlinked_hwaddr_changed)(struct teamd_context *ctx,
> +                                      struct team_ifinfo *ifinfo, void *priv);
>         int (*option_changed)(struct teamd_context *ctx,
>                               struct team_option *option, void *priv);
>         char *option_changed_match_name;
> @@ -210,6 +212,8 @@ int teamd_event_ifinfo_ifname_changed(struct teamd_context *ctx,
>                                       struct team_ifinfo *ifinfo);
>  int teamd_event_ifinfo_admin_state_changed(struct teamd_context *ctx,
>                                            struct team_ifinfo *ifinfo);
> +int teamd_event_unlinked_ifinfo_hwaddr_changed(struct teamd_context *ctx,
> +                                              struct team_ifinfo *ifinfo);
>  int teamd_events_init(struct teamd_context *ctx);
>  void teamd_events_fini(struct teamd_context *ctx);
>  int teamd_event_watch_register(struct teamd_context *ctx,
> @@ -313,6 +317,7 @@ static inline unsigned int teamd_port_count(struct teamd_context *ctx)
>         return ctx->port_obj_list_count;
>  }
>
> +int teamd_port_add(struct teamd_context *ctx, uint32_t ifindex);
>  int teamd_port_add_ifname(struct teamd_context *ctx, const char *port_name);
>  int teamd_port_remove_ifname(struct teamd_context *ctx, const char *port_name);
>  int teamd_port_remove_all(struct teamd_context *ctx);
> diff --git a/teamd/teamd_events.c b/teamd/teamd_events.c
> index 1a95974..a377090 100644
> --- a/teamd/teamd_events.c
> +++ b/teamd/teamd_events.c
> @@ -184,6 +184,23 @@ int teamd_event_ifinfo_admin_state_changed(struct teamd_context *ctx,
>         return 0;
>  }
>
> +int teamd_event_unlinked_ifinfo_hwaddr_changed(struct teamd_context *ctx,
> +                                              struct team_ifinfo *ifinfo)
> +{
> +       struct event_watch_item *watch;
> +       int err;
> +
> +       list_for_each_node_entry(watch, &ctx->event_watch_list, list) {
> +               if (watch->ops->unlinked_hwaddr_changed) {

I would probably flip the order of this. There is no point in doing
the loop if unlinked_hwaddr_changed is NULL. So you could probably
check for the function pointer first and then run the loop if it is
set.

> +                       err = watch->ops->unlinked_hwaddr_changed(ctx, ifinfo,
> +                                                                 watch->priv);
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +       return 0;
> +}
> +
>  int teamd_events_init(struct teamd_context *ctx)
>  {
>         list_init(&ctx->event_watch_list);
> diff --git a/teamd/teamd_ifinfo_watch.c b/teamd/teamd_ifinfo_watch.c
> index f334ff6..8d01a76 100644
> --- a/teamd/teamd_ifinfo_watch.c
> +++ b/teamd/teamd_ifinfo_watch.c
> @@ -60,6 +60,15 @@ static int ifinfo_change_handler_func(struct team_handle *th, void *priv,
>                                 return err;
>                 }
>         }
> +
> +       team_for_each_unlinked_ifinfo(ifinfo, th) {
> +               if (team_is_ifinfo_hwaddr_changed(ifinfo) ||
> +                   team_is_ifinfo_hwaddr_len_changed(ifinfo)) {
> +                       err = teamd_event_unlinked_ifinfo_hwaddr_changed(ctx, ifinfo);
> +                       if (err)
> +                               return err;
> +               }
> +       }

I guess this is needed for the generic case, but as I said we wouldn't
probably need to worry about this in the VF/virtio case as the VM is
probably locked to a specific MAC address.

Also I am not sure about this bit. It seems like this is only checking
for the HW addr being changed. Is that bit set if a new interface is
registered? I haven't worked on teamd so I am not familiar with how it
handles new interfaces. Also how does this handle existing interfaces
that were registered before you started this?

>         return 0;
>  }
>
> diff --git a/teamd/teamd_per_port.c b/teamd/teamd_per_port.c
> index 09d1dc7..21e1bda 100644
> --- a/teamd/teamd_per_port.c
> +++ b/teamd/teamd_per_port.c
> @@ -331,6 +331,11 @@ next_one:
>         return tdport;
>  }
>
> +int teamd_port_add(struct teamd_context *ctx, uint32_t ifindex)
> +{
> +       return team_port_add(ctx->th, ifindex);
> +}
> +
>  int teamd_port_add_ifname(struct teamd_context *ctx, const char *port_name)
>  {
>         uint32_t ifindex;
> @@ -338,7 +343,7 @@ int teamd_port_add_ifname(struct teamd_context *ctx, const char *port_name)
>         ifindex = team_ifname2ifindex(ctx->th, port_name);
>         teamd_log_dbg("%s: Adding port (found ifindex \"%d\").",
>                       port_name, ifindex);
> -       return team_port_add(ctx->th, ifindex);
> +       return teamd_port_add(ctx, ifindex);
>  }
>
>  static int teamd_port_remove(struct teamd_context *ctx,

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

