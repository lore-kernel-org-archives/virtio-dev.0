Return-Path: <virtio-dev-return-13255-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C72CEB64DD
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 12:13:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DA7D12CAE1
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 12:13:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C892C9867EB
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 12:13:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B75F2986725; Thu,  6 Jul 2023 12:13:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E492986726;
	Thu,  6 Jul 2023 12:13:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHAp/TjbIZ0Ry7gytWw+C9Eps87FQUxojQ4qArtCWqLPe/hpfW9R2jSrNW7dTRIlFwzxcDPM+1YF1WD1O0r+deZrfBM1vt8h/rI9ppV949o4NRACDMeAF88VGoh2MNWNL0W2eLXdhTwrO6+ncNF5bFUGujhkFQYpD+TiIzzOm5dL10+LRDpzYJ/kENNhZ/skisI8ZtHhRyMPKkErD8pB/exqeYDEZ92F9pqPPYHOgIl3+R2Z5Tw3UiOXrDpSj6zwxPAJF1yOpY0a2UzLjmp8o9OTTonD8l+IpgPlyxkB1DnIdx3fj80EZOzXW93JD0CIKovLwGiwq09X8H+ie8sxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWD3WCAFJlIpkVzrMDlrqbrDR2MrTc9Cf7mQfRAR4MU=;
 b=PlTuutEFchloLcIGtCqCrMVSfF5m3L0OHUcwrqtS39MrbeqmmDtn1EJK4Xlz30PQuyi1AN45c3mECiSNm0XbI+AMEtOv89kJ37VK6+kFD3VtMJbfOJpYbVz7WteuJeA6V1Ax3ArZCLratm6RTLKovwwJqQybPmhULPY9XkUuesLetEypJNyIcCe2XqninTmi6MBepIqls/XhfTWkExAAiw0roJxI91vaQQcjQiZTxleGuX+VaSQCpUhDtwQ/fmJVfzg+1AsB3sNuGqvlBNen6jokjKjkPef0Mieh5+HO/DkbtF3OPCWFHx6yd41VR9N3/XLGx6B7x0Gnp5DKRnMRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Gerd Hoffmann <kraxel@redhat.com>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Stefano Stabellini
	<sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
	<Jiqian.Chen@amd.com>
Thread-Topic: [virtio-dev] Re: [VIRTIO GPU PATCH 1/1] virtio-gpu: Add new
 feature flag VIRTIO_GPU_F_FREEZING
Thread-Index: AQHZqzRZDb5h7n47GkO7SNRrNNz5RK+sqs2AgACIQIA=
Date: Thu, 6 Jul 2023 12:13:38 +0000
Message-ID:
 <BL1PR12MB5849B31B8BF6444BAB6BBE91E72CA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230630092138.855107-1-Jiqian.Chen@amd.com>
 <20230630092138.855107-2-Jiqian.Chen@amd.com>
 <haz6sjtqvuzmyorb2v4pzgfkau3xudzkttosmpheov5slqox37@wdtafkzirhvi>
In-Reply-To: <haz6sjtqvuzmyorb2v4pzgfkau3xudzkttosmpheov5slqox37@wdtafkzirhvi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: IA1PR12MB6041.namprd12.prod.outlook.com
 (15.20.6544.003)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|IA0PR12MB8695:EE_
x-ms-office365-filtering-correlation-id: eb3e6094-7a8d-4c1e-85ee-08db7e1a6e3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VJbHFpJHpoZ2Bw6BQ6hck9MvUaUdmNebKh5zXsEvO4sNqGKgzs5ACrA6uYMPvgaCKM8NUOobbx8HxpAyor2P26shdoYQRzexJLKzEPW/Bn+p/PECQcAkDaFwXJeuwn5cNI4kZuebxky3QUWtGK9HpgUoGIOGWkUOB40VYesGKhNLkEvJnA5p8WVsWjzwQ0+B3cv2n3kN4ZjjId+019afpwOdAhWaB3jqyNUpO3Ub9O+5qW1FEtP+c76w1b49BL5etdvV/A9ayQU9kx3IGIeE/JmAg2cjVUBZD+ODNfjdajdpZ6aB0ZBF1cqKIfwABvL6f5wXNYAaQ8ZYk2YDqxP0uDQI+BBkJBPukP79M8sJKFeSQbKXlUw3QCjSyGuqcoeMjdIZNvNe2h/t7sszpOPU49wWnCM0XCprPpqxQ14KY/03x3+Fh+hn2YahQaope08no2/aeKlNRBY9V1fhPm2klPKxUvXSjYzEXDn0rDi+xy9gpcvRdHcmyZqiKH9dYmF4ky9yMXHT/Cj9pEw70YLkCSorfZWILeqXXEZJK4fhSGahNpPOQaRLKB8Ion4MKUFZYSP9VgwGf6mFAsY2hPpugcPavCFgXABEOFdI9ZCX5/BmshR+vP9dFf5ovFI6T5ad
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(71200400001)(478600001)(7696005)(76116006)(54906003)(53546011)(26005)(186003)(9686003)(66946007)(2906002)(41300700001)(66446008)(6916009)(316002)(8936002)(66556008)(64756008)(8676002)(5660300002)(52536014)(122000001)(66476007)(4326008)(38100700002)(38070700005)(33656002)(83380400001)(6506007)(55016003)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnNRZllBVHZUWEUzaUtoZDlqd0tYREFrVGx1TW5haDhuVU5VOEhoTk1Fa3Bz?=
 =?utf-8?B?djB0elhNWHJxc0ZvMjBpeUZQRi9DeUkxTUVrKzdHeE9nV2ZyY29ScEhKSE4v?=
 =?utf-8?B?N3dRSUhIekluSTdiTDA3TmxaVjdwd3FRZkV6em41ZDE2a2NzLy80SFpGN0hj?=
 =?utf-8?B?eWhhK3FKQTF0eGFTaEFkSXJLZTRiL0FoMEtnc2FZV0dWMkM1VWxCMjNsL2l4?=
 =?utf-8?B?SkRENUozZjlTOTJVY1kzaFdLU0had1RHdGdLcm5GV2ZaazhIcVBLNC94cENz?=
 =?utf-8?B?Vm9iY3h5cmZwQUNDKzJ4aTVyWnU4V0lUREFvb29hSS9KWVhyK2pUWmVVdmtL?=
 =?utf-8?B?eHorR3YwUXFHMEF1bDl3UkFLaTZ5UEJ6VXM3bG9BZ0w2NENFWnNsTlBsU2M4?=
 =?utf-8?B?OGUxZHdZNW9qVEJKN2I4clI1REE1emhiQ0FwQnoxM3Ava3Z0VWxSOWswUWV1?=
 =?utf-8?B?UFlYYXpXU3VNN2Ryd2g2SHphY0RXYkFXeEhJNjFUSWY1aHJzU2VyaERaYno0?=
 =?utf-8?B?Y015UE9DRGdpSVFMWkpiTWd1bnU1Zk45WDYyOEE4Q0RkaUlIV0xGdytkdmQx?=
 =?utf-8?B?Z2o2K0hDeFg3S2xneHdvQk4rQzhNdE8vMlFCQ2wwNmlkdWRBQkFRdXhRZmpX?=
 =?utf-8?B?TXhKUjNyTFVRNXBQYlk3REVvMmNrdU9TV056SDdaUHFvQXBNTVQrL2s3enVS?=
 =?utf-8?B?eEpPM2FURzBPanJCUFhBSkpXbWR4YUdvbzJxWUFKL0s2clNPMzlHWEU4QXpH?=
 =?utf-8?B?R2N3c1hMSTlnWDFCVFcwK0xRV1psanFLVUF2MmVCREV5MkMzbzNPRXJHRVRO?=
 =?utf-8?B?dzlvd3JSMFF6eHdEQ3ZYdWFkM250QjhXWEVpL21ITDdMK3pnTHdHNHdoL3lR?=
 =?utf-8?B?LzVUTjJDek5jNTdGTWk1bytrNldYTktpSi9jaC9XTVdaQklZVy9nMmp5QjFP?=
 =?utf-8?B?VFFoZENsN3Z5UG1iK2tnRTFyOUJLM0k1T0ZYMFdmbnZqdUJjNjE2dk1VQ0dO?=
 =?utf-8?B?cUVwVGYxU1RHdWlrNlBJQ1Z2bjl3Z1o5aU5hOGhTdWFrZlZidGw0NC84bG5Y?=
 =?utf-8?B?NTFnRGIzZTMyejRTeHVHZkY0QllBMXRjUE52bGthclBmckN0TzFSSXpZOW8r?=
 =?utf-8?B?QUo1bVdkT21EMURMdGFIbGs4ZnN0ZmdnQmJ3QVlPYVpXWjVlM1VjbVpRYVlE?=
 =?utf-8?B?T2FSSElwOE1qZEJLb2FmcVdKYVFEemllTVRPcWhlampRZ1NxTkhmcHZ0R29M?=
 =?utf-8?B?VDJRWklvb0l3SVdFRGw2Y2MzdFJSUnZFYkRDV2xmNTFpRlJBd3BtRkhSejZG?=
 =?utf-8?B?eVgxQkdlVFdZbW9pSC9xU3VlbVRmZDB2Y0FMZDA2NUtITXNyVFhUSXA0b0Jv?=
 =?utf-8?B?clIzcW82TkNCUWwrQWxxMVNzcXJtOXhkMmxOZ3NYK3pXQjVoZlFSVWN2MWhU?=
 =?utf-8?B?R2NEcDZIZ2NmWTNSUTFZQTFqaFdUOW5XRXBoSzFud2RYUWVPREFsODdGSnNJ?=
 =?utf-8?B?bzdUQXNvLzZSVHd3eVFkN0pacXhwbzhNTHNSZytua21sbVBzejNRNVMwTGRz?=
 =?utf-8?B?L1FkSlpFZ0xqMkJrY3l2TkRtSGgyeUt1VU45Um5oLzdacElnWm10T3E2QjBE?=
 =?utf-8?B?dkp0UHRSUmFiRzlZemk4TkdvVXB2eW9vVDk0bk9yWGJwc1p5Wk5MY2JDWEd5?=
 =?utf-8?B?MEQ0M3IrYkZRMUxNbmE4SXdkSEVYZGR0MWhoVTF6YTZ3aGpNZk5MQytQbnRV?=
 =?utf-8?B?ZHpudEMzY0huTGd1Zk9vdjgvZGRqMHBtbHRzSTQ3dFVTOWRnSVh3Y2VqZ2JG?=
 =?utf-8?B?UmdGNGx0bVRpN2lCNjJXdDZOdDVyV2UzK1VKZFc2dEVYV21mUnp4RzBxN2RC?=
 =?utf-8?B?THc2WkwzQTYzZEFXMUFPb2ZqQzZHLzUrR0F3bzc0UTQwTDc0VTJJOFVHNDJq?=
 =?utf-8?B?am5kekFxdm9MdGFhVkhlbkd1YjJ3UWpGN3ZicUY2N2lmcEc3U2NXVTJ6a0Jz?=
 =?utf-8?B?Sm1ZM3dMakttN2gxQmVnaHI1b1YyVmZMQ1EwRVd2bXQ5TmRycDUyTEU0Wmc5?=
 =?utf-8?B?ZU1uL05JY0tHMXpmKzJNNjczN3hocmJ3QUFSc2l4TVJtZmtlUmhQWG5OVjZ2?=
 =?utf-8?Q?mSfg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5AFAD830F01D24C877AB78070E51FE0@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3e6094-7a8d-4c1e-85ee-08db7e1a6e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 12:13:38.6309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CF/6aQ5RyYmGa+xKtZ5o9BuRG7Jv21iPjFcidHPS4Ismab76SAO3SCGC5OGfveb8JeJ0gnzOXVdnrpLQBFuu/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
Subject: Re: [virtio-dev] Re: [VIRTIO GPU PATCH 1/1] virtio-gpu: Add new
 feature flag VIRTIO_GPU_F_FREEZING

SGkgR2VyZCBIb2ZmbWFubiwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldyBhbmQgc3VnZ2Vz
dGlvbnMuDQoNCk9uIDIwMjMvNy82IDE5OjU0LCBHZXJkIEhvZmZtYW5uIHdyb3RlOg0KPiAgIEhp
LA0KPiANCj4+ICtcaXRlbVtWSVJUSU9fR1BVX0NNRF9TVEFUVVNfRlJFRVpJTkddDQo+PiArTm90
aWZ5IGZyZWV6aW5nIHN0YXR1cyB0aHJvdWdoIGNvbnRyb2xxLg0KPj4gK1JlcXVlc3QgZGF0YSBp
cyBcZmllbGR7c3RydWN0IHZpcnRpb19ncHVfc3RhdHVzX2ZyZWV6aW5nfS4NCj4+ICtSZXNwb25z
ZSB0eXBlIGlzIFZJUlRJT19HUFVfUkVTUF9PS19OT0RBVEEuDQo+PiArDQo+PiArR3Vlc3Qgbm90
aWZpZXMgUUVNVSBpZiB2aXJ0aW8tZ3B1IGlzIGluIGZyZWV6aW5nIHN0YXR1cyBvciBub3QgaW4g
XGZpZWxke2ZyZWV6aW5nfS4NCj4+ICt6ZXJvIG1lYW5zIGl0IGlzIG5vdCBpbiBmcmVlemluZyBz
dGF0dXMsIG5vbmUtemVybyBpcyB0aGUgb3Bwb3NpdGUuDQo+PiArV2hlbiBndWVzdCBpcyBpbiBm
cmVlemluZyBzdGF0dXMsIFFFTVUgd2lsbCBub3QgZGVzdHJveSByZXNvdXJjZXMuDQo+IA0KPiBU
aGlzIHNob3VsZCBiZSBtb3JlIGNsZWFyIHdoaWNoIHJlc291cmNlcyBhcmUgbWVhbnQgaGVyZS4g
IEp1c3QNCj4gcmVzb3VyY2VzIGNyZWF0ZWQgYnkgVklSVElPX0dQVV9DTURfUkVTT1VSQ0VfQ1JF
QVRFXyogY29tbWFuZHM/DQo+IE9yIGFsbCBvYmplY3RzIChpbmNsdWRpbmcgY3Vyc29ycywgc2Nh
bm91dHMsIDNEIGNvbnRleHRzLCAuLi4pPw0KPiBPciBzb21lIG90aGVyIHNldD8NCg0KWWVzLCB5
b3UgYXJlIHJpZ2h0LCBpdCBzaG91bGQgYmUgY2xlYXJlciBhYm91dCByZXNvdXJjZSBoZXJlLiBJ
IHdpbGwgZWxhYm9yYXRlIG9uIHRoZSB0eXBlcyBvZiByZXNvdXJjZXMgaW4gdGhlIG5leHQgdmVy
c2lvbi4NCg0KPiANCj4gSSd2ZSBzZWVuIG9uIHRoZSAoY29kZSkgcGF0Y2ggZGlzY3Vzc2lvbiB0
aGUgdG9waWMgb2YgZGlmZmVyZW50DQo+IHN1c3BlbmQgbW9kZXMgKHMzL3M0KSBjYW1lIHVwLg0K
PiBXaGF0IHdhcyB0aGUgY29uY2x1c2lvbiB0aGVyZT8NCj4gU2hvdWxkIGEgbm90ZSBhYm91dCB0
aGlzIGJlIGFkZGVkIHRvIHRoZSBzcGVjIHRvbz8NCg0KTXkgbW9kaWZpY2F0aW9uIHdhcyBvcmln
aW5hbGx5IHRvIHN1cHBvcnQgeGVuJ3MgczMgZnVuY3Rpb24sIGJ1dCBJIHdpbGwgdHJ5IHM0IGxv
Y2FsbHksIGlmIHM0IGRvZXMgbm90IHdvcmssIEkgd2lsbCBhZGQgaW5zdHJ1Y3Rpb25zIGhlcmUu
DQoNCj4gDQo+IHRha2UgY2FyZSwNCj4gICBHZXJkDQo+IA0KPiANCj4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
IFRvIHVuc3Vic2NyaWJlLCBlLW1haWw6IHZpcnRpby1kZXYtdW5zdWJzY3JpYmVAbGlzdHMub2Fz
aXMtb3Blbi5vcmcNCj4gRm9yIGFkZGl0aW9uYWwgY29tbWFuZHMsIGUtbWFpbDogdmlydGlvLWRl
di1oZWxwQGxpc3RzLm9hc2lzLW9wZW4ub3JnDQo+IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkpp
cWlhbiBDaGVuLg0K

