Return-Path: <virtio-dev-return-11498-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FDDC678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 01:14:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C0049F3F45
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 01:14:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B4FB7986703
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 01:14:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AA4749866E5; Wed,  8 Mar 2023 01:14:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 947D59866E1;
	Wed,  8 Mar 2023 01:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7ENPd3SjiulDcabOsJ59Ifn/wm+WbDDD5JnPX2R6ZwlIDyN+YcWgJHCwimeZHqVGXeIJ7M+0VeFMxaLiIN3T2npVayyeh+3VR5skozhLQkwXHZ6NsXIZo/VYXL2bQUmFwEOyOj+vsb5b7N3ZrWF1W91Lr4WLSPrwRkeFlmRgLMC1Am+66GeLtSCKOvzsfpYzEhwqtYNROLbMHVy3Oz02t93NDrqXLFcNoI+L6H+TtlAGAj3mpptvztv258vMZfY+wy3T52/pqJDZ2G1Xn2c2UrxWelErsQMEHZm61PT17kKy15KAavN6O88b4CkQSPRaIUVV/1VvJWD+wXTFi6mGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lBLIXLsn39DvS9UeIE7fNMbtVZiq9wLJag/K/Q5eBQ=;
 b=fQQZ/BiATanNWFrLK7mhr5Ff0G6xTmCUkhuXWgFXhIFBqIjFOWsoXJhIAoYbMxu40XCCGDucxOmujKIVI77bnrCG4F4PSg9X/suEaQO6flSMPjnoYwsEhLiOU6Skr9XFv5vMN9tU5OFkNONK/MPWA1qht0VgWLhfD4zUq6I0Tn6F2A7zgX2CGN9DgLsJ5uzE++pvP3tTKthRX33j83kvdqWjv+Fve4tbE9yF3TTpOdQX/fzfeLAgjGlI0ATTGqVvT4uGwOZaTjBYaRej5NplJ3iZkGykGpNItEsHZpkFCx0W8AVdRb6gcYYlGCWN3Ng5MP2l3Z0DsYeB8U6yGlhQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v10 03/10] admin: introduce group administration commands
Thread-Index:
 AQHZTdJ4xYP6q68fXEe3YRvTaF+rUK7pCgmAgASROQCAAnSDAIAABaZggAADSwCAAABbwA==
Date: Wed, 8 Mar 2023 01:14:24 +0000
Message-ID:
 <PH0PR12MB5481BD649EB0EC76F7ED0D9CDCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230302201912.GC2554028@fedora>
 <20230302185803-mutt-send-email-mst@kernel.org>
 <20230303131703.GB2866370@fedora>
 <20230303081900-mutt-send-email-mst@kernel.org>
 <4f869944-4ccd-c51e-0f30-dc3ba15ffd52@nvidia.com>
 <20230307192752-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811A704524CE59CCDB2B1EDCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230307200307-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230307200307-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN0PR12MB5811:EE_
x-ms-office365-filtering-correlation-id: 5b232dd8-43f3-4706-11ab-08db1f7274d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OFYm4dSyYb+S1/f/cjKaiqeCwN6D7wqMjuPKo6vEPVnudWga52xaiEyji1+8ZCbnWzAwUPZ4vrOYMMqn6FwKqzs54sWeO8TiH2BhaOODHSPisBPpGXMPtDu8whtEOZo47B6a97vXy0NHTDBycIclOYs40kuZZOm9qEtYjqoxw7cBhWgfRXZ00XiMlcPe5KHB+kskXWjx07RlSAMmoKAOXw7oa7MUqCbQ8F3dZpCapJ825C9SlLbmPQVYqEvxLo+4Aq5a7ZfRyg1vk16iY2anb3/N2K+DwaaptlyM3tlx2RWMhilNPTl2pNOSgCZdfv+t4ddfCN3RSqIU5Rzi9p1itP6RNpFt2mfaPTPX4BFLVMJoSOeFc6YrEidEAuwTTNk8uokG9aZdz6a2NhO/tXiyklKeYlNKYCdrA219BK/sD4KPfv1vjw9G2IcqDDspn6kwf2Kl2OqichTYLSwBp/VpmSAZ5qeh86eIFg6lEGQQ0Ic2J898Yh6gS9/+y8aPqAK48M6yhPlPy/NnfdzvVIyW1hlYDg7u2jp4OSizNDy7sNFEW/F4ke+HvpBhNt9WR5jSmuzvaZS1NbdcrwEiY5OYcvJCPz1vNKvcDlMU9ky2RYkOR1/JEcDst4nwtkewqm4lnT7C9k4vPCjWmmAgWsMov1ePS1un14wjkbJZLadPUWaPuV7pkkVdnzFnFM/KUkRNCHcpTUuUp4nyzg6qWZgiYw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199018)(8676002)(8936002)(4326008)(6916009)(76116006)(66446008)(41300700001)(66946007)(66476007)(66556008)(7416002)(5660300002)(2906002)(122000001)(86362001)(33656002)(38100700002)(38070700005)(64756008)(7696005)(6506007)(71200400001)(316002)(54906003)(107886003)(478600001)(55016003)(52536014)(83380400001)(9686003)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j65/cbAH3YMePIqP2rkHP5s+cOu/kRY2fc0A5zAUI4/RH5rMC3GFxjLs+AS1?=
 =?us-ascii?Q?wvmgcioBWjZZdsRJQm3dcraXtyCZG8QWc59+yhM+aRn2NJdp+gDSklUiIbDN?=
 =?us-ascii?Q?kuGK2M0xV5sbG4iWqAV3VYEs7f9u0L1Hw4fo81r2CeW50+7OD14vuSN4QW2u?=
 =?us-ascii?Q?cfTpNs8GQrDzEobI+k102tkijiyhJ27lqniWVGk3XZe5EeAC4y/LbVQgqcmm?=
 =?us-ascii?Q?s0o8NFpcygR5hhFvG0Zuj7/glYs3gIBZixc23SA2W7EzIZUWCzlEZpU5ybW/?=
 =?us-ascii?Q?JdPOKyXL4E2bPDe5J9KKZIM3XcUbe82si/RWG9oWbDVXopa29uEU6DdpjH88?=
 =?us-ascii?Q?wkGf6eD79KEPECTLUrwZEJfUY/62FCHbpch92NjdEzJyRYzXqRABG09KGZDg?=
 =?us-ascii?Q?CI9KYk4TagNsfkD+uaUFYU9is6lSVxnTgFNovPThS8NJqN6qRg4TsmLJMRmh?=
 =?us-ascii?Q?+lfHakkbf+4Ds7/8F65btYZMh2bM3ku8JRPEGf7APArAd4EXwwvWD8hrFz4P?=
 =?us-ascii?Q?VmL2YMAPp/K52zL1JfPEA9rq+PWSeYNSvkoVmGrHmG+cIWT9CPD+N7EO3CvY?=
 =?us-ascii?Q?FgWRQb7iibBlAaMZe0WaECLd8LoLDLUPWb49yNJIEohyHWb93WT/10kKeJ5w?=
 =?us-ascii?Q?X2e7d5h0hUk9cQ+TPeffdGIXNCbI3UH5+rZbDvKSRngGTheqcm9HFiF0Dcqu?=
 =?us-ascii?Q?hVDPJihQRd+iwqFojYlqyhs0u+T0xZcn4XW5SmXfiKxgk9TZ8L7xHK1JvdXM?=
 =?us-ascii?Q?dhrlv4vxV0TAuywiLUx9qUtLgl3qNAnBtl3q7qJBPpAPFIRE2xMq96JtOEqU?=
 =?us-ascii?Q?Ywdk7vDOCg6Hqm9AKNvtHr7Yyh5aZj2wCwsz92IMowtAXf47g91hK3s589gu?=
 =?us-ascii?Q?dGvm/gndLnfoc0WjOUrIUgBKX7EVWFIO9fgBfQmg5BQHodN8YkMA12VO+TAf?=
 =?us-ascii?Q?h8/GsSlKI3qxhFvzxRbaLj7PZznenQwJZFH3XUzRuGbFBLoq1L+UWL9afWfa?=
 =?us-ascii?Q?P0mV8iuAS7tQkuXItV1NT2XpEswUJ1N8rfXxKGWBrNB5shLd9j74Ywf73pAC?=
 =?us-ascii?Q?YAeJ2ZanP2WkhwC4kTP53ryS41Nr7keFNEsWAps1SSERm69CSqQzgXUWZKJN?=
 =?us-ascii?Q?JAh0MPd4HvzkqBRMYJPm4clfb3pQnKekEEPMdWybrtxN1KWmofc9VV5oYm1E?=
 =?us-ascii?Q?PdwqstUh/EDKjezVbAanh6XUNMQrCZOIAmwBPRo9ri/LQa2QG7XluYJeE1oh?=
 =?us-ascii?Q?J345e0WCVOzOE6m6Mz+5SVo5x4urdCi2e5mWXqB12qKHbRIR2FCFL5W09TDj?=
 =?us-ascii?Q?psLow+BOKXSS43qO8LMtcnPlQfqM6y8KJmzjxU/xZ6tQhg4uig2efcB+QUmQ?=
 =?us-ascii?Q?FIMXygK4pZwJYqW7uvGgxcw3+hnC/vK5BAX9RNdUw5EXn/ZLD9av+FUPjunX?=
 =?us-ascii?Q?CQjgbzu4FYci5jIYLv+ZA72vlor0Bgwav+qUZQlxxHpI/q2iyb/a+Se2pVcy?=
 =?us-ascii?Q?uEA7DjgT+TdjJFjDqc4OmvyM+TbXvLX1YkKxaNuzVYJFiJMCEWPaczaZ53d5?=
 =?us-ascii?Q?+eoNGThZsS7y8E7olH0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b232dd8-43f3-4706-11ab-08db1f7274d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 01:14:24.9688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umCBAqGiEa2ZuRzVJ9m0l49KDS7YcdVSAtJ9Jv35ej5LMfXs6Hq63QRoTkJOOdwPmf/d+TpX7/+trVgppCIFHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
Subject: [virtio-dev] RE: [PATCH v10 03/10] admin: introduce group administration commands



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, March 7, 2023 8:06 PM
>=20
> On Wed, Mar 08, 2023 at 01:01:27AM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, March 7, 2023 7:34 PM COMMAND_SPECIFIC_ERR is just
> > > way too much detail - commands generally just should not fail it's a
> > > quality of implementation issue.
> >
> > I disagree partially.
> >
> > 1. Hw device !=3D sw_hypervisor device.
> > Device may fail or error out that may need want sw driver to retry.
> > Like Stefan's example, it may need to return timeout/retry intermittent=
ly.
> > Doesnt means the device is broken at that point.
> >
> > 2. A device implementation may not have imposed a certain locking schem=
e
> to synchronize VF enablement with VF provisioning.
> > ENODEV can reflect two commands not synchronized.
> >
> > So Boolean 0 =3D success, 22 =3D error is not the right way to craft th=
e spec.
> > Many times, those sub-error codes are good indications of what may have
> gone wrong in the field.
> > Useful for the quality issue you pointed out to debug.
>=20
> Maybe, but I think we can just leave this stuff for later. Too much hand-=
waving,
> when we add commands that actually need this kind of ability that is when=
 we
> will add the relevant error codes.
Sounds good to me.
I thought the whole reason you wanted to use errno.h was to reuse all appli=
cable error codes from it.
And so doing it in one go appeared natural to me.
As long as adding new error codes doesn't need new feature bits or new/exte=
nsion of list commands, adding later looks good to me.
As long as we agree that adding more error codes to reflect specific errors=
 is fine, (not Boolean 22), seems like a good direction.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

